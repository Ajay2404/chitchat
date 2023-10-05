//app file

import 'package:chitchat/main.dart';
import 'package:chitchat/routes/route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(
        name: _routeName.switchAccountScreen,
        page: () => MyApp()),

  ];
}
