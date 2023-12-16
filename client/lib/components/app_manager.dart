import 'package:client/components/dialogs/add_address_dialog.dart';
import 'package:client/components/nav_bar.dart';
import 'package:client/components/notched_button.dart';
import 'package:client/components/cointracker_app_bar.dart';
import 'package:client/models/app_page.dart';
import 'package:client/pages/home.dart';
import 'package:client/pages/addresses.dart';
import 'package:client/models/address_info.dart';
import 'package:client/models/transaction.dart';
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
  late AppPage _currentPage = AppPage.home;

  @override
  void initState() {
    _currentPage = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(_homePage);
  }

  IconData get _notchedButtonIcon => _currentPage == AppPage.home ? Icons.add : Icons.account_balance_wallet_outlined;

  Scaffold _buildScaffold(Widget page) {
    return Scaffold(
      appBar: CoinTrackerAppBar(
        currentPage: _currentPage,
        onDelete: _handleAddressDeleted,
      ),
      extendBody: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NotchedButton(
        icon: _notchedButtonIcon,
        onPressed: _handleNotchedButtonPressed,
      ),
      bottomNavigationBar: const NavBar(),
      body: page,
    );
  }

  void _onAddressClicked(String addressId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => _buildScaffold(_walletPage),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
      // MaterialPageRoute(builder: (context) => _buildScaffold(_walletPage)),
    );
    setState(() => _currentPage = AppPage.wallet);
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
        Navigator.pop(context);
        setState(() {
          _currentPage = AppPage.home;
        });
        break;
    }
  }
  Widget get _homePage => Home(
    addresses: [
      AddressInfo(
        title: 'My Address',
        id: '12ajsbd1231451p1ij23n1k23n1',
        balance: 119028301.1234,
        transactions: [],
      ),
      AddressInfo(
        title: '',
        id: 's9dfja0sdja0d710j910dj19jd191j-',
        balance: 123,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
      AddressInfo(
        title: 'Address #3 With a VERY VERY LONG NAME',
        id: '1283asd901s90uaomsd099-1j2ij',
        balance: 12918239801.999,
        transactions: [],
      ),
    ],
    onAddressClicked: _onAddressClicked,
  );
  Widget get _walletPage => Addresses(
    addressInfo: AddressInfo(
      title: 'My Address',
      id: '12ajsbd1231451p1ij23n1k23n1',
      balance: 119028301.1234,
      transactions: [
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
        Transaction(id: '123abc', transferAmount: -12354.43),
      ],
    ),
    onTitleEdit: _handleTitleEdited,
  );

  void _handleAddressDeleted() {
    // Fetch current address id
    // TODO: Write some deletion logic here.
  }

  void _handleAddressAdded(String address) {
    // TODO: Write some deletion logic here.
  }

  void _handleTitleEdited(String newTitle) {
    // TODO: Write some edit logic here.
  }
}