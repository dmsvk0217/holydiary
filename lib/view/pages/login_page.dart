import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/view/pages/build_page.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Lottie.network(
            'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/H.json'),
        const SizedBox(
          height: 250,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.textfield,
          ),
          width: 300,
          height: 60,
          child: TextButton(
            onPressed: () {
              Get.to(() => const BuildPage());
            },
            child: Text(
              "Google 로그인",
              style:
                  TextStyle(color: ColorManager.text, fontSize: FontSize.s14),
            ),
          ),
        ),
        //Image.asset('assets/googleicon.png', height: 50, width: 50),
      ],
    );
  }
}
