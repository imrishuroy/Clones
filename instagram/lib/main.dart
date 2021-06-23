import 'package:flutter/material.dart';
import 'package:instagram/config/custom_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: '/',
    );
  }
}
