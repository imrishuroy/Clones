import 'package:flutter/material.dart';
import '/screens/home/widgets/top_bar.dart';

import 'widgets/bottom_bar.dart';
import 'widgets/main_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // Top section
          const TopBar(),

          Expanded(child: MainContentLayout()),

          const BottomToolbar(),
        ],
      ),
    );
  }
}
