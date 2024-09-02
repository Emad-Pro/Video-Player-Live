import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/responsive_layout/app_styles.dart';
import '../../model/player_model/quality_model.dart';
import '../../presenter/video_player_cubit.dart';

class VideoBuildSelectQualityItem extends StatelessWidget {
  const VideoBuildSelectQualityItem(
      {super.key, required this.state, required this.toElement});
  final StreamQuality toElement;
  final VideoPlayerState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = context.read<VideoPlayerCubit>();
        if (toElement.resolution == 'Auto') {
          cubit.changeQuality(null);
        } else {
          cubit.changeQuality(toElement.url);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: toElement.resolution == state.currentQuality!.resolution
                  ? Theme.of(context).colorScheme.primary
                  : null,
              borderRadius: BorderRadius.circular(12)),
          width: 70,
          height: 30,
          child: Text(
            toElement.resolution,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(context, fontSize: 14)),
          ),
        ),
      ),
    );
  }
}
