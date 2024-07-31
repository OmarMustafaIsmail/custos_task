import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: SvgPicture.asset(
        'assets/icons/custos_logo.svg',
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcATop,
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
      ),
      backgroundColor: Colors.blue, // Customize with your Palette.kAppBarColor
      iconTheme: const IconThemeData(
          color: Colors.white), // Customize with your Palette.kWhiteColor
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
