import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget1 extends StatefulWidget {
  final String videoUrl; // Can be a file path or network URL
  final bool isLocalFile;

  VideoPlayerWidget1({required this.videoUrl, this.isLocalFile = false});

  @override
  _VideoPlayerWidget1State createState() => _VideoPlayerWidget1State();
}

class _VideoPlayerWidget1State extends State<VideoPlayerWidget1> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isLocalFile) {
      _controller = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {});
        });
    } else {
      _controller = VideoPlayerController.network(widget.videoUrl)..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : CircularProgressIndicator();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}