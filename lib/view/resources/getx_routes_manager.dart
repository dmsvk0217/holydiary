import 'package:get/route_manager.dart';
import 'package:holydiary/getQuestion.dart';
import 'package:holydiary/resultPage.dart';
import 'package:holydiary/view/pages/build_page.dart';
import 'package:holydiary/view/pages/home_page.dart';
import 'package:holydiary/view/pages/login_page.dart';
import 'package:holydiary/view/pages/testcompo.dart';

class Routes {
  static const String buildRoute = "/";
  static const String homeRoute = "/home";
  static const String getQuestionRoute = "/getQuestion";
  static const String resultPage = "/result";
  static const String testPage = "/test";
  static const String loginPage = '/login';
}

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: Routes.buildRoute,
    page: () => const BuildPage(),
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
    name: Routes.testPage,
    page: () => const Testcompo(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.loginPage,
    page: () => const LoginPage(), // edit
    transition: Transition.fade,
  ),
];
