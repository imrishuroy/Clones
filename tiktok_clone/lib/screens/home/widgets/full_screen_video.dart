import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final String? videoUrl;

  const FullScreenVideo({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _videoController;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

    _videoController = VideoPlayerController.asset(widget.videoUrl ?? '')
      ..initialize().then((_) {
        setState(() {
          _loading = false;
          _videoController.play();
          _videoController.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          )
        : VideoPlayer(_videoController);
  }
}
