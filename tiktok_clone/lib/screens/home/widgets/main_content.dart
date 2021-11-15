import 'package:flutter/material.dart';

import 'action_toolbar.dart';
import 'full_screen_video.dart';
import 'video_description.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MainContentLayout(),
      ],
    );
  }
}

class MainContentLayout extends StatelessWidget {
  final List<String> videoUrls = [
    'assets/videos/video1.mp4',
    'assets/videos/video2.mp4',
    'assets/videos/video_6.mp4',
    'assets/videos/video_1.mp4',
    'assets/videos/video_3.mp4',
  ];

  MainContentLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      // children: List.generate(5, (index) {
      //   return const ContentView();
      // }),
      children:
          videoUrls.map((String url) => ContentView(videoUrl: url)).toList(),
    );
  }
}

class ContentView extends StatelessWidget {
  final String videoUrl;

  const ContentView({Key? key, required this.videoUrl}) : super(key: key);

  Widget get middleSection => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            VideoDescription(),
            ActionsToolbar(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),

          // padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FullScreenVideo(
              videoUrl: videoUrl,
            ),
          ),
        ),
        //middleSection,
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              VideoDescription(),
              ActionsToolbar(),
            ],
          ),
        ),
      ],
    );
  }
}

class SideActions extends StatelessWidget {
  const SideActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
