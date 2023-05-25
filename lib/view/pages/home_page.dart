import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var iconList = [
    Icons.check,
    Icons.check,
    Icons.check,
    Icons.check,
  ];
  var _bottomNavIndex = 1;

  var pages = [
    Center(
      child: Text("test1"),
    ),
    Center(
      child: Text("test2"),
    ),
    Center(
      child: Text("test3"),
    ),
    Center(
      child: Text("test4"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo : route to the WriteDiaryPage
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() {
          _bottomNavIndex = index;
        }),
        //other params
      ),
    );
  }
}
