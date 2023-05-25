import 'package:get/route_manager.dart';
import 'package:holydiary/getQuestion.dart';
import 'package:holydiary/resultPage.dart';
import 'package:holydiary/view/pages/home_page.dart';

class Routes {
  static const String homeRoute = "/";
  static const String getQuestionRoute = "/getQuestion";
  static const String resultPage = "/resultPage";
}

List<GetPage<dynamic>> getPages = [
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
];
