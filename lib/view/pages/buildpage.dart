import 'package:flutter/material.dart';
import 'package:holydiary/view/pages/homepage.dart';
import 'package:holydiary/view/resources/color_manager.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({super.key});

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  var bottomNavIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          bottomNavIndex = index;
        });
      },
      children: <Widget>[
        HomePage(),
        HomePage(),
        HomePage(),
        HomePage(),
        HomePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HolyDiary"),
      ),
      body: buildPageView(),
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
