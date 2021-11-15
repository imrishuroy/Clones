import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '@firstjonny',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Video title and some other stuff'),
            Row(
              children: const [
                Icon(
                  Icons.music_note,
                  size: 15.0,
                  color: Colors.white,
                ),
                Text('Artist name - Album name - song',
                    style: TextStyle(fontSize: 12.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
