import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/pages/build_page.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'package:holydiary/view/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Text(
              "Holy Diary",
              style: TextStyle(
                color: ColorManager.text,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 30),
            Lottie.asset('assets/bible.json', width: 180),
            const SizedBox(
              height: 140,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.textfield,
              ),
              width: 300,
              height: 60,
              child: TextButton(
                onPressed: () async {
                  await signInWithGoogle();
                  Get.to(() => const BuildPage());
                },
                child: Text(
                  "Google 로그인",
                  style: TextStyle(
                    color: ColorManager.text,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.textfield,
              ),
              width: 300,
              height: 60,
              child: TextButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInAnonymously();
                    userController.uid.value = userCredential.user!.uid;
                    if (await userController.isFirstTimeSignIn()) {
                      userController.addAnonymousUser();
                    }
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "operation-not-allowed":
                        print(
                            "Anonymous auth hasn't been enabled for this project.");
                        break;
                      default:
                        print("Unknown error.");
                    }
                  }
                  Get.to(() => const BuildPage());
                },
                child: Text(
                  "Guest 로그인",
                  style: TextStyle(
                      color: ColorManager.text, fontSize: FontSize.s14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
