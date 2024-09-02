import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presenter/video_player_cubit.dart';
import 'video_player_controllers_widgets.dart';
import 'video_player_view_widget.dart';

class VideoPlayerViewBody extends StatelessWidget {
  const VideoPlayerViewBody({super.key, required this.state});
  final VideoPlayerState state;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: state.isFullscreen
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          context.read<VideoPlayerCubit>().toggleVisibility();
        },
        child: SizedBox(
          width: double.infinity,
          height: state.isFullscreen
              ? MediaQuery.sizeOf(context).height
              : MediaQuery.sizeOf(context).height / 3,
          child: Stack(children: [
            VideoPlayerViewWidget(state: state),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
            VideoPlayerConrollersWidgets(state: state),
          ]),
        ),
      ),
    );
  }
}
