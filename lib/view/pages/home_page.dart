import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bottomNavIndex = 0;
  var pages = const [
    Center(child: Text("test1")),
    Center(child: Text("test2")),
    Center(child: Text("test3")),
    Center(child: Text("test4")),
    Center(child: Text("test5")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[bottomNavIndex],
      bottomNavigationBar: Container(
        color: ColorManager.appbarBackground,
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: ColorManager.appbarBackground,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomNavIndex,
          selectedItemColor: ColorManager.navIconActive,
          unselectedItemColor: ColorManager.navIcon,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (value) {
            setState(() {
              bottomNavIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.today_outlined,
              ),
              label: '캘린더',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: '타임라인',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.create,
              ),
              label: '일기쓰기',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
              ),
              label: '성경',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}
