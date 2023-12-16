import 'package:client/components/dialogs/delete_address_dialog.dart';
import 'package:client/models/app_page.dart';
import 'package:client/models/synchronization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinTrackerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppPage currentPage;
  final String? activeAddressId;
  final Synchronization synchronization;
  final void Function() onDelete;

  const CoinTrackerAppBar({
    super.key,
    required this.currentPage,
    required this.activeAddressId,
    required this.synchronization,
    required this.onDelete,
  });
  
  @override
  State<StatefulWidget> createState() => _CoinTrackerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CoinTrackerAppBarState extends State<CoinTrackerAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: SvgPicture.network(
          'https://s3-us-west-1.amazonaws.com/coin-tracker-public/static/images/icons/logo_blue.svg',
        ),
      ),
      leadingWidth: MediaQuery.sizeOf(context).width / 2.5,
      actions: [
        if (widget.currentPage == AppPage.wallet) ..._addIcons(),
      ],
    );
  }

  List<Widget> _addIcons() {
    return [
      if (widget.activeAddressId != null) _getSyncIcon(),
      IconButton(
        onPressed: _launchWindow,
        icon: const Icon(Icons.open_in_new),
      ),
      IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => DeleteAddressDialog(onDelete: widget.onDelete),
        ),
        icon: const Icon(Icons.delete),
      ),
      const SizedBox(width: 8),
    ];
  }

  Icon _getSyncIcon() {
    IconData iconData;
    Color color;

    switch(widget.synchronization) {
      case Synchronization.desynced:
        iconData = Icons.check_circle_outline;
        color = Colors.black38;
        break;
      case Synchronization.synced:
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case Synchronization.invalid:
        iconData = Icons.cancel_outlined;
        color = Colors.red;
        break;
    }

    return Icon(
      iconData,
      color: color,
    );
  }

  void _launchWindow() async {
    if (widget.activeAddressId == null) return;

    final Uri url = Uri.parse('https://www.blockchain.com/explorer/addresses/btc/${widget.activeAddressId}');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}