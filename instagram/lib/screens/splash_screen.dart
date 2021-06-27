import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/screens/login/login_screen.dart';
import 'package:instagram/screens/nav/nav_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          print(state);
          if (state.status == AuthStatus.unauthenticated) {
            // return login/signup screen
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // return NavScreen
            Navigator.of(context).pushNamed(NavScreen.routeName);
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
