import 'package:client/components/dialogs/add_address_dialog.dart';
import 'package:client/components/nav_bar.dart';
import 'package:client/components/notched_button.dart';
import 'package:client/components/cointracker_app_bar.dart';
import 'package:client/models/app_page.dart';
import 'package:client/models/synchronization.dart';
import 'package:client/network/server.dart';
import 'package:client/pages/home.dart';
import 'package:client/pages/addresses.dart';
import 'package:client/models/address_info.dart';
import 'package:flutter/material.dart';

class AppManager extends StatefulWidget {
  final AppPage initialPage;

  const AppManager({
    super.key,
    required this.initialPage,
  });

  @override
  State<StatefulWidget> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  late AppPage _currentPage;
  late List<AddressInfo> _addresses;
  String? _activeAddressId;

  @override
  void initState() {
    _currentPage = widget.initialPage;
    _addresses = [];
    _activeAddressId = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(_homePage);
  }

  Scaffold _buildScaffold(Widget page) {
    final synchronization = _addresses.isEmpty ?
      Synchronization.desynced : _addresses.firstWhere((address) => address.id == _activeAddressId).synchronization;

    return Scaffold(
      appBar: CoinTrackerAppBar(
        currentPage: _currentPage,
        activeAddressId: _activeAddressId,
        synchronization: synchronization,
        onDelete: _handleAddressDeleted,
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NotchedButton(
        currentPage: _currentPage,
        onPressed: _handleNotchedButtonPressed,
      ),
      bottomNavigationBar: NavBar(
        onSync: _handleSync,
        onFetch: _handleFetch,
      ),
      body: page,
    );
  }

  void _onAddressClicked(String addressId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => _buildScaffold(Addresses(
          addressInfo: _addresses.firstWhere((address) => address.id == addressId),
          onTitleEdit: _handleTitleEdited,
        )),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
      // MaterialPageRoute(builder: (context) => _buildScaffold(_walletPage)),
    );
    setState(() {
      _currentPage = AppPage.wallet;
      _activeAddressId = addressId;
    });
  }

  void _handleNotchedButtonPressed() {
    switch (_currentPage) {
      case AppPage.home:
        showDialog(
          context: context,
          builder: (context) => AddAddressDialog(
            onAddAddress: _handleAddressAdded,
          ),
        );
        break;
      case AppPage.wallet:
        setState(() {
          _currentPage = AppPage.home;
          _activeAddressId = null;
        });
        Navigator.pop(context);
        break;
    }
  }
  Widget get _homePage => Home(
    addresses: _addresses,
    onAddressClicked: _onAddressClicked,
  );

  void _handleAddressAdded(String addressId) async {
    if (_addresses.any((address) => address.id == addressId)) {
      const alreadyAddedNotif = SnackBar(
        content: Text(
          'This address is already added!',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(alreadyAddedNotif);

      return;
    }

    final addressInfo = await Server().getAddress(addressId: addressId);
    setState(() => _addresses.add(addressInfo));
  }

  void _handleAddressDeleted() {
    setState(() {
      _addresses.removeWhere((address) => address.id == _activeAddressId);
      _activeAddressId = null;
      _currentPage = AppPage.home;
    });
    Navigator.pop(context);
  }

  void _handleTitleEdited(String newTitle) {
    setState(() {
      final addressIndex = _addresses.indexWhere((address) => address.id == _activeAddressId);
      _addresses[addressIndex].title = newTitle;
    });
  }

  void _handleSync() async {
    if (_addresses.isEmpty) return;

    switch (_currentPage) {
      case AppPage.home:

        final newAddresses = await Server().replaceAllAddresses(addresses: _addresses);
        for(var i = 0; i < newAddresses.length; i++) {
          final transactions = await Server().getAllTransactionsForAddress(address: newAddresses[i]);
          newAddresses[i].transactions = transactions;

          newAddresses[i].updateSynchronization();
        }

        setState(() => _addresses = newAddresses);
        break;
      case AppPage.wallet:
        if (_activeAddressId == null) return;

        final address = await Server().getAddress(addressId: _activeAddressId!);
        final transactions = await Server().getAllTransactionsForAddress(address: address);

        address.transactions = transactions;
        address.updateSynchronization();

        setState(() => _addresses
          ..retainWhere((address) => address.id != _activeAddressId)
          ..add(address));
        break;
    }
  }

  void _handleFetch() async {
    if (_addresses.isEmpty) return;

    switch (_currentPage) {
      case AppPage.home:
        if (_activeAddressId == null) return;

        final addresses = <AddressInfo>[];
        for(final address in _addresses) {
          final transactions = await Server().getAllTransactionsForAddress(address: address);
          address.transactions = transactions;
          addresses.add(address);
        }

        setState(() => _addresses = _addresses);
        break;
      case AppPage.wallet:
        if (_activeAddressId == null) return;

        final addressToFetch = _addresses.firstWhere((address) => address.id == _activeAddressId);
        final transactions = await Server().getAllTransactionsForAddress(address: addressToFetch);

        addressToFetch.transactions = transactions;
        setState(() => _addresses
          ..retainWhere((address) => address.id != _activeAddressId)
          ..add(addressToFetch));
        break;
    }
  }
}