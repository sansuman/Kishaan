import 'package:Testing2/config/custom_route.dart';
import 'package:Testing2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:Testing2/pages/splash_page.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashPage(),
      '/LoginPage': (_) => LoginPage(),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "LoginPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => LoginPage()
            );
    }
  }
}
