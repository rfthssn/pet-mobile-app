import 'package:flutter/material.dart';

class PetDemoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  PetDemoAppBar({title})
      : _title = title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.blueGrey,
      ),
      title: Text(_title != null ? _title : 'Pet Demo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.orange,
      centerTitle: true,
    );
  }
}