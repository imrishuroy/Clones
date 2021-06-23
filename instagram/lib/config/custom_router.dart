import 'package:flutter/material.dart';
import 'package:instagram/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/'),
          builder: (_) => Scaffold(
            body: const Text('HomePage'),
          ),
        );

      case SplashScreen.routeName:
        return SplashScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error '),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Text('Something went wrong!'),
      ),
    );
  }
}
