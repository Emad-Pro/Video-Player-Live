import 'package:flutter/material.dart';

import '../../presenter/video_player_cubit.dart';
import 'video_player_center_controller_button.dart';
import 'video_player_header_controller_button.dart';
import 'video_player_progress_bar.dart';

class VideoPlayerConrollersWidgets extends StatelessWidget {
  const VideoPlayerConrollersWidgets({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state.isVisibility,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 5, left: 5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VideoPlayerHeaderControllerButton(state: state),
              VideoPlayerCenterControllerButton(state: state),
              VideoPlayerProgressBar(state: state),
            ]),
      ),
    );
  }
}
