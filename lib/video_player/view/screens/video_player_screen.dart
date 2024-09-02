import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_live/video_player/model/player_service/player_service.dart';
import '../../../core/enum/request_state.dart';
import '../../presenter/video_player_cubit.dart';
import '../widgets/video_player_view_body.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerCubit(
          "https://vo-live.cdb.cdn.orange.com/Content/Channel/MajidChildrenChannel/HLS/index.m3u8",
          PlayerService()),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                  builder: (context, state) {
                switch (state.requestState) {
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case RequestState.success:
                    return state.videoPlayerController!.value.isInitialized
                        ? VideoPlayerViewBody(state: state)
                        : Container();
                  case RequestState.erorr:
                    return Text(state.errorMessage);
                }
              }),
            )),
      ),
    );
  }
}
