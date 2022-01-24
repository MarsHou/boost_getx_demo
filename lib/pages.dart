import 'package:boost_getx/main.dart';
import 'package:get/get.dart';

class RouteGet {
  ///pages map
  static final List<GetPage> getPages = [
    GetPage(
        name: "/mainPage",
        page: () => MainPage(data: {}),
        transition: Transition.cupertino),
    GetPage(
        name: "/simplePage",
        page: () => SimplePage(data: {}),
        transition: Transition.cupertino),
  ];
}
