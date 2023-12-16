import 'package:client/components/dialogs/delete_address_dialog.dart';
import 'package:client/utils/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinTrackerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppPage currentPage;
  final void Function() onDelete;

  const CoinTrackerAppBar({
    super.key,
    required this.currentPage,
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
        if (widget.currentPage == AppPage.wallet) ..._addDeleteIcon(),
      ],
    );
  }

  List<Widget> _addDeleteIcon() {
    return [
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
}