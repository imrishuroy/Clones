import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';

// import 'ui/home/home_view.dart';

void main() => runApp(const TikTokClone());

class TikTokClone extends StatelessWidget {
  const TikTokClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // for example video player

      // theme: ThemeData.dark(),
      theme: ThemeData(
        // Uncomment in phase 3 to apply white to text
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      //  home: const SplashScreen(),
      home: const HomeScreen(),
    );
  }
}
