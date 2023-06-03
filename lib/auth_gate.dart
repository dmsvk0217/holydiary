import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:holydiary/view/pages/build_page.dart';

class AuthGate extends StatelessWidget {
  AuthGate({Key? key}) : super(key: key);
  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              GoogleProviderConfiguration(
                scopes: [
                  'email',
                  'https://www.googleapis.com/auth/contacts.readonly',
                ],
                clientId:
                    '437606811201-9vfmvdsre194edb4gmm6h7iprls79d95.apps.googleusercontent.com',
              ),
            ],
            footerBuilder: (context, action) => TextButton(
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
              },
              child: const Text("login in guest"),
            ),
          );
        }

        return const BuildPage();
      },
    );
  }
}
