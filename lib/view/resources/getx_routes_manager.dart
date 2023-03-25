import 'package:get/route_manager.dart';
import 'package:holydiary/view/pages/homepage.dart';

class Routes {
  static const String homeRoute = "/";
}

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: Routes.homeRoute,
    page: () => const HomePage(),
    transition: Transition.fade,
  ),
];
