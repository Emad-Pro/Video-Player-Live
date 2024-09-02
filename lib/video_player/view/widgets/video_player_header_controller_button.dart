import 'package:flutter/material.dart';

import '../../presenter/video_player_cubit.dart';
import 'video_build_select_quality_item.dart';

class VideoPlayerHeaderControllerButton extends StatelessWidget {
  const VideoPlayerHeaderControllerButton({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: state.isFullscreen
            ? MediaQuery.sizeOf(context).height * 0.08
            : MediaQuery.sizeOf(context).height * 0.04,
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: state.qualityModel
              .map(
                (toElement) => VideoBuildSelectQualityItem(
                    state: state, toElement: toElement),
              )
              .toList(),
        ));
  }
}
