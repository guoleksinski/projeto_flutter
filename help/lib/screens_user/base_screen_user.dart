import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:help/screens_user/home_user.dart';
import 'package:help/screens_user/map_user.dart';
import 'package:help/screens_user/profile_user.dart';

int _page = 0;
final screens = [
  const HomeUser(),
  const ProfileUser(),
  const MapUser(),
];
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

class BaseScreenUser extends StatefulWidget {
  const BaseScreenUser({Key? key}) : super(key: key);

  @override
  State<BaseScreenUser> createState() => _BaseScreenUserState();
}

class _BaseScreenUserState extends State<BaseScreenUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.compare_arrows,
              size: 30,
              color: Colors.black,
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.pink,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[_page]);
  }
}
