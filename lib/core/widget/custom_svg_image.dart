import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }
}

class CustomSvgWithColor extends StatelessWidget {
  const CustomSvgWithColor({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
    );
  }
}
