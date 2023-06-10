import 'package:get/route_manager.dart';
import 'package:holydiary/auth_gate.dart';
import 'package:holydiary/getQuestion.dart';
import 'package:holydiary/resultPage.dart';
import 'package:holydiary/view/pages/bible_read_page.dart';
import 'package:holydiary/view/pages/build_page.dart';
import 'package:holydiary/view/pages/home_page.dart';
import 'package:holydiary/view/pages/login_page.dart';

class Routes {
  static const String buildRoute = "/";
  static const String homeRoute = "/home";
  static const String getQuestionRoute = "/getQuestion";
  static const String resultPage = "/result";
  static const String testPage = "/test";
  static const String loginPage = '/login';
  static const String authPage = '/auth';
  static const String bibleReadPage = '/bibleRead';
}

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: Routes.buildRoute,
    page: () => const BuildPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.bibleReadPage,
    page: () => BibleReadPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.authPage,
    page: () => const AuthGate(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.homeRoute,
    page: () => const HomePage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.getQuestionRoute,
    page: () => const GetQuestion(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.resultPage,
    page: () => const ResultPage("dsff"),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.loginPage,
    page: () => LoginPage(), // edit
    transition: Transition.fade,
  ),
];
