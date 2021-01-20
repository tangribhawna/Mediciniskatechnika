import 'package:flutter/material.dart';
import 'package:medicinskatechnika/ui/screens/categoriylisting.dart';
import 'package:medicinskatechnika/ui/screens/home.dart';
import 'package:medicinskatechnika/ui/screens/splashscren.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashScreen(),
    '/home': (BuildContext context) => Home(),
    '/category': (BuildContext context) => CategoryListing()
  };

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');

    if (path[0] != '') return null;
    if (path[1] == 'otpregister') {
      // this is not needed here yet
    }

    return null;
  }

  static MaterialPageRoute unknownRoute(RouteSettings settings) {
    print("Router: " + settings.name + ' is not defined.');

    return null;
  }
}
