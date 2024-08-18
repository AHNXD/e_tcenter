import 'package:e_tcenter/constatnt.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class ShowVideoPage extends StatefulWidget {
  static const routeName = '/showVideo';
  const ShowVideoPage({super.key});

  @override
  State<ShowVideoPage> createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Container(
            color: appColor, // Replace with your desired color
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              "الفيديو",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController),
        ),
      ),
    );
  }
}
