import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';

// keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
// keytool -list -v -keystore debug.keystore -alias androiddebugkey

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 32,
              ),
              Text(
                "고객센터",
                style: TextStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.text,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.textfield,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone_android,
                        size: 16,
                        color: ColorManager.navIcon,
                      ),
                      label: Text(
                        "의견 보내기",
                        style: TextStyle(
                            fontSize: FontSize.s14, color: ColorManager.text),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: ColorManager.text,
                  thickness: 0.2,
                  height: 0,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone_android,
                        size: 16,
                        color: ColorManager.navIcon,
                      ),
                      label: Text(
                        "설정하기",
                        style: TextStyle(
                            fontSize: FontSize.s14, color: ColorManager.text),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: ColorManager.text,
                  thickness: 0.2,
                  height: 0,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await userController.logOut();
                      },
                      icon: Icon(
                        Icons.phone_android,
                        size: 16,
                        color: ColorManager.navIcon,
                      ),
                      label: Text(
                        "로그아웃",
                        style: TextStyle(
                            fontSize: FontSize.s14, color: ColorManager.text),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
