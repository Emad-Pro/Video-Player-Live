part of 'video_player_cubit.dart';

class VideoPlayerState extends Equatable {
  final VideoPlayerController? videoPlayerController;
  final PlaybackState playbackState;
  final RequestState requestState;
  final Duration currentPosition;
  final Duration totalPosition;
  final bool isFullscreen;
  final bool isVisibility;
  final List<StreamQuality> qualityModel;
  final RequestState qualityState;
  final String urlLive;
  final String errorMessage;
  final StreamQuality? currentQuality;
  const VideoPlayerState(
      {this.videoPlayerController,
      this.playbackState = PlaybackState.initial,
      this.requestState = RequestState.loading,
      this.qualityState = RequestState.loading,
      this.currentPosition = Duration.zero,
      this.totalPosition = Duration.zero,
      this.isFullscreen = false,
      this.isVisibility = true,
      this.errorMessage = '',
      this.qualityModel = const [],
      this.urlLive = '',
      this.currentQuality});
  VideoPlayerState copyWith(
      {VideoPlayerController? videoPlayerController,
      PlaybackState? playbackState,
      RequestState? requestState,
      Duration? currentPosition,
      Duration? totalPosition,
      bool? isFullscreen,
      bool? isVisibility,
      String? urlLive,
      List<StreamQuality>? qualityModel,
      String? errorMessage,
      RequestState? qualityState,
      StreamQuality? currentQuality}) {
    return VideoPlayerState(
        requestState: requestState ?? this.requestState,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        playbackState: playbackState ?? this.playbackState,
        currentPosition: currentPosition ?? this.currentPosition,
        totalPosition: totalPosition ?? this.totalPosition,
        isFullscreen: isFullscreen ?? this.isFullscreen,
        isVisibility: isVisibility ?? this.isVisibility,
        qualityModel: qualityModel ?? this.qualityModel,
        qualityState: qualityState ?? this.qualityState,
        currentQuality: currentQuality ?? this.currentQuality,
        urlLive: urlLive ?? this.urlLive,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        videoPlayerController,
        playbackState,
        requestState,
        currentPosition,
        totalPosition,
        isFullscreen,
        isVisibility,
        qualityModel,
        qualityState,
        urlLive,
        errorMessage,
        currentQuality
      ];
}

enum PlaybackState {
  initial,
  loading,
  ready,
  playing,
  paused,
  completed,
  buffering,
  error,
}
