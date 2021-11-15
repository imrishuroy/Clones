import 'package:flutter/material.dart';

import 'tik_tok_icons.dart';

class BottomToolbar extends StatelessWidget {
  static const double navigationIconSize = 20.0;
  static const double createButtonWidth = 38.0;

  const BottomToolbar({Key? key}) : super(key: key);

  Widget get customCreateIcon => SizedBox(
        width: 45.0,
        height: 27.0,
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: createButtonWidth,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 45, 108),
                  borderRadius: BorderRadius.circular(7.0))),
          Container(
              margin: const EdgeInsets.only(right: 10.0),
              width: createButtonWidth,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 211, 234),
                  borderRadius: BorderRadius.circular(7.0))),
          Center(
              child: Container(
            height: double.infinity,
            width: createButtonWidth,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
            child: const Icon(
              Icons.add,
              size: 20.0,
            ),
          )),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(TikTokIcons.home,
            color: Colors.white, size: navigationIconSize),
        const Icon(TikTokIcons.search,
            color: Colors.white, size: navigationIconSize),
        customCreateIcon,
        const Icon(TikTokIcons.messages,
            color: Colors.white, size: navigationIconSize),
        const Icon(TikTokIcons.profile,
            color: Colors.white, size: navigationIconSize)
      ],
    );
  }
}
