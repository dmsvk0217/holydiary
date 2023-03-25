import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';

void main() {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HolyDiary",
      // theme: getApplicationTheme(),
      initialRoute: Routes.homeRoute,
      getPages: getPages,
    );
  }
}
