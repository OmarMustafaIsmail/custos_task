import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';


class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {required this.text,
        this.success = false,
        super.key,
        this.containerColour = Palette.kDangerRedColor,
        this.textColor = Palette.kBlackColor});
  final String text;
  final bool success;
  final Color containerColour;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: width * 0.3,
        height: height * 0.1,
        constraints: BoxConstraints(
          maxWidth:width * 0.55,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: containerColour,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: AutoSizeText(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                // fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}

void showFloatingSnackBar(
    BuildContext context, String message, Color containerColour,
    {Color textColor = Palette.kBlackColor}) {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.5 ,
      right: 0,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(
              child: CustomSnackBar(
                text: message,
                containerColour: containerColour,
                textColor: textColor,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay entry after some time (e.g., 2 seconds)
  Future.delayed(const Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}
