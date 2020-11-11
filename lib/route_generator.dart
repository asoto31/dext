import 'package:flutter/material.dart';

import 'package:dext/login.dart';
import 'package:dext/home.dart';
import 'package:dext/counts.dart';
import 'package:dext/users.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print(args);
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/counts':
        return MaterialPageRoute(builder: (_) => Counts());
      case '/users':
        return MaterialPageRoute(builder: (_) => Users());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
