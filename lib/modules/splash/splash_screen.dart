import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kSideMenuColor,
      body: Center(
        child: SvgPicture.asset('assets/icons/custos_logo.svg'), // You can customize this with an image or animation
      ),
    );
  }
}