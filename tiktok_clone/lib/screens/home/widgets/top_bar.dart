import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: const EdgeInsets.only(bottom: 15.0),
      alignment: const Alignment(0.0, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Following'),
          Container(
            width: 15.0,
          ),
          const Text(
            'For you',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
