import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final void Function() onSync;
  final void Function() onFetch;

  const NavBar({
    super.key,
    required this.onSync,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(
              iconData: Icons.sync,
              label: 'Sync',
              onPressed: onSync,
          ),
          Container(),
          _buildTabItem(
            iconData: Icons.download,
            label: 'Fetch',
            onPressed: onFetch,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required IconData iconData,
    required String label,
    required void Function() onPressed,
  }) {
    return SizedBox(
      width: 175,
      child: Material(
        type: MaterialType.transparency,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkResponse(
          highlightShape: BoxShape.circle,
          onTap: onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, color: Colors.white),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
