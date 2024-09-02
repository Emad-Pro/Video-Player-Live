import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widget/custom_svg_image.dart';
import '../../presenter/video_player_cubit.dart';

class VideoPlayerCenterControllerButton extends StatelessWidget {
  const VideoPlayerCenterControllerButton({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: IconButton(
              onPressed: () {
                context.read<VideoPlayerCubit>().onSeek(Duration(seconds: -5));
              },
              icon: const CustomSvgImage(
                imagePath: "assets/svg_image/video_controller/skip_revious.svg",
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: IconButton(
              onPressed: () {
                if (state.playbackState == PlaybackState.completed ||
                    state.playbackState == PlaybackState.initial ||
                    state.playbackState == PlaybackState.paused) {
                  context.read<VideoPlayerCubit>().onPlay();
                } else if (state.playbackState == PlaybackState.playing) {
                  context.read<VideoPlayerCubit>().onPause();
                }
              },
              icon: CustomSvgImage(
                imagePath: state.playbackState == PlaybackState.completed
                    ? "assets/svg_image/video_controller/replay.svg"
                    : state.playbackState == PlaybackState.playing
                        ? "assets/svg_image/video_controller/pause.svg"
                        : state.playbackState == PlaybackState.paused
                            ? "assets/svg_image/video_controller/play.svg"
                            : "assets/svg_image/video_controller/play.svg",
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: IconButton(
              onPressed: () {
                context.read<VideoPlayerCubit>().onSeek(Duration(seconds: 5));
              },
              icon: const CustomSvgImage(
                imagePath: "assets/svg_image/video_controller/skip_next.svg",
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: IconButton(
                onPressed: () {
                  context.read<VideoPlayerCubit>().toggleFullscreen();
                },
                icon: CustomSvgImage(
                    imagePath: !state.isFullscreen
                        ? "assets/svg_image/video_controller/full_screen.svg"
                        : "assets/svg_image/video_controller/quit_full_screen.svg")),
          ),
        ],
      ),
    );
  }
}
