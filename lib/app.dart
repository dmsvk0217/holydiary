import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'package:holydiary/view/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
// keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HolyDiary",
      theme: getApplicationTheme(),
      initialRoute: Routes.authPage,
      getPages: getPages,
      localizationsDelegates: const [
        // 다언어 설정
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // 다언어 설정
        Locale('ko', ''), //한국어
        Locale('en', ''), //영어
      ],
    );
  }
}
