import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

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
              onPressed: _refreshPressed,
          ),
          Container(),
          _buildTabItem(
            iconData: Icons.download,
            label: 'Fetch',
            onPressed: _retrievePressed,
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

  void _retrievePressed() {

  }

  void _refreshPressed() {

  }
}
