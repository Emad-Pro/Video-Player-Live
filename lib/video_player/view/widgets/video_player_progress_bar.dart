import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presenter/video_player_cubit.dart';

class VideoPlayerProgressBar extends StatelessWidget {
  const VideoPlayerProgressBar({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      timeLabelPadding: 0,
      timeLabelTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      progress: state.currentPosition,
      total: state.videoPlayerController!.value.duration,
      barHeight: 3.0,
      timeLabelType: TimeLabelType.totalTime,
      timeLabelLocation: TimeLabelLocation.sides,
      thumbRadius: 5.0,
      onSeek: (duration) {
        context.read<VideoPlayerCubit>().onSeek(duration);
      },
    );
  }
}
