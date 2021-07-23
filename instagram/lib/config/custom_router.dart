import 'package:flutter/material.dart';
import 'package:instagram/screens/edit_profile/edit_profile_screen.dart';
import 'package:instagram/screens/login/login_screen.dart';
import 'package:instagram/screens/nav/nav_screen.dart';
import 'package:instagram/screens/profile/profile_screen.dart';
import 'package:instagram/screens/screens.dart';
import 'package:instagram/screens/signup/signup_screen.dart';

class CustomRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Route ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(
            body: Center(child: Text('HomePage')),
          ),
        );

      case SplashScreen.routeName:
        return SplashScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> onGenerateNestedRoute(RouteSettings settings) {
    print('Route ${settings.name}');
    switch (settings.name) {
      case ProfileScreen.routeName:
        return ProfileScreen.route(
            args: settings.arguments as ProfileScreenArgs);
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(
            args: settings.arguments as EditProfileScreenArgs?);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: '/error '),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Text('Something went wrong!'),
      ),
    );
  }
}
