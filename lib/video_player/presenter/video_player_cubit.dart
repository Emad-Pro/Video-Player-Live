import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../core/enum/request_state.dart';
import '../model/player_model/quality_model.dart';
import '../model/player_service/player_service.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? _controller;
  final PlayerService playerService;

  VideoPlayerCubit(String videoUrl, this.playerService)
      : super(const VideoPlayerState()) {
    _initializeVideoPlayer(videoUrl);
    toggleFullscreen();
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await playerService.fetchM3U8Content(videoUrl);

    result.when(success: (content) {
      final qualities = _parseM3U8Content(content);
      final autoQuality =
          StreamQuality(resolution: "Auto", bandwidth: 250, url: videoUrl);

      emit(state.copyWith(
        qualityState: RequestState.success,
        qualityModel: [autoQuality, ...qualities],
        currentQuality: autoQuality,
        urlLive: videoUrl,
      ));
      _loadVideo(autoQuality.url);
    }, failure: (failure) {
      emit(state.copyWith(
        requestState: RequestState.erorr,
        errorMessage: failure.message,
      ));
    });
  }

  Future<void> changeQuality(String? path) async {
    String? fullPath;
    if (path != null) {
      fullPath = _buildFullUrl(state.urlLive, path);
    }
    await _pauseAndRemoveListeners();
    _loadVideo(fullPath ?? state.urlLive);

    final newQuality = _findQualityByUrl(path ?? state.urlLive) ??
        _unknownQuality(fullPath ?? state.urlLive);
    emit(state.copyWith(currentQuality: newQuality));
  }

  Future<void> _loadVideo(String url) async {
    try {
      await _disposeController();

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(
          webOptions: const VideoPlayerWebOptions(
            controls: VideoPlayerWebOptionsControls.enabled(),
          ),
        ),
      );

      _controller!.addListener(_listenToChanges);
      await _controller!.initialize();

      emit(state.copyWith(
        requestState: RequestState.success,
        videoPlayerController: _controller,
        totalPosition: _controller!.value.duration,
      ));

      onPlay();
    } catch (e) {
      emit(state.copyWith(
        requestState: RequestState.erorr,
        playbackState: PlaybackState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void onPlay() {
    _controller?.play().then((_) {
      emit(state.copyWith(playbackState: PlaybackState.playing));

      Future.delayed(const Duration(seconds: 2), () {
        if (state.playbackState != PlaybackState.paused) {
          toggleVisibility();
        }
      });
    });
  }

  void onPause() {
    _controller?.pause();
    emit(state.copyWith(playbackState: PlaybackState.paused));
  }

  void onSeek(Duration position) {
    _controller?.seekTo(position);
    emit(state.copyWith(videoPlayerController: _controller));
  }

  void toggleFullscreen() {
    final isFullscreen = !state.isFullscreen;
    emit(state.copyWith(isFullscreen: isFullscreen));

    SystemChrome.setPreferredOrientations(
      isFullscreen
          ? [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
          : [DeviceOrientation.portraitUp],
    );
  }

  void toggleVisibility() {
    emit(state.copyWith(isVisibility: !state.isVisibility));
  }

  void _listenToChanges() {
    if (_controller != null) {
      final value = _controller!.value;
      emit(state.copyWith(
        videoPlayerController: _controller,
        currentPosition: value.position,
        totalPosition: value.duration,
        playbackState:
            value.isPlaying ? PlaybackState.playing : PlaybackState.paused,
      ));
    }
  }

  Future<void> _disposeController() async {
    await _controller?.dispose();
    _controller = null;
  }

  Future<void> _pauseAndRemoveListeners() async {
    await _controller?.pause();
    _controller?.removeListener(_listenToChanges);
  }

  String? _buildFullUrl(String baseUrl, String endPath) {
    final pathChannel = baseUrl.substring(0, baseUrl.lastIndexOf('/') + 1);
    return '$pathChannel$endPath';
  }

  StreamQuality _unknownQuality(String url) {
    return StreamQuality(resolution: 'Unknown', bandwidth: 0, url: url);
  }

  StreamQuality? _findQualityByUrl(String url) {
    return state.qualityModel.firstWhere((quality) => quality.url == url);
  }

  List<StreamQuality> _parseM3U8Content(String content) {
    final lines = content.split('\n');
    final qualities = <StreamQuality>[];

    for (var i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('#EXT-X-STREAM-INF')) {
        final resolution =
            RegExp(r'RESOLUTION=(\d+x\d+)').firstMatch(lines[i])?.group(1);
        final bandwidth = int.tryParse(
            RegExp(r'BANDWIDTH=(\d+)').firstMatch(lines[i])?.group(1) ?? '');
        final url = lines[i + 1].trim();

        if (resolution != null && bandwidth != null) {
          qualities.add(StreamQuality(
              resolution: resolution, bandwidth: bandwidth, url: url));
        }
      }
    }

    return qualities;
  }
}
