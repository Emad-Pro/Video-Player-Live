import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../presenter/video_player_cubit.dart';

class VideoPlayerViewWidget extends StatelessWidget {
  const VideoPlayerViewWidget({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
          aspectRatio: state.videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(state.videoPlayerController!)),
    );
  }
}
