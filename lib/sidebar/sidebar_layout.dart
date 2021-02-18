import 'package:flutter/material.dart';
import 'package:side_nav_template/pages/home_page.dart';
import 'package:side_nav_template/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),
        ],
      ),
    );
  }
}
