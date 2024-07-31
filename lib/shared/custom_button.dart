import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final Function() onPressed;
  final ButtonColor buttonColor;
  final double size;
  final double radius;
  final Color textColor;
  final bool showError;
  final String errorText;
  final double bottomPadding;
  final bool loading;
  final FontWeight fontWeight;
  final double height;

  const CustomButton({
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    this.size = 20.0,
    this.radius = 15,
    this.textColor = Colors.white,
    this.showError = false,
    this.errorText = "",
    this.bottomPadding = 1.0,
    this.loading = false,
    super.key,
    this.fontWeight = FontWeight.w900,
    required this.height,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    // if (widget.showError) {
    //   setState(() {
    //     height = 50*ratio;
    //   });
    // } else {
    //   setState(() {
    //     height = 0;
    //   });
    // }
    return Column(
      children: [
        InkWell(
          onTap: widget.onPressed,
          child: Container(
              height: widget.height,
              width: double.infinity,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                boxShadow: const [
                  // BoxShadow(
                  //     offset: Offset(0, 10),
                  //     blurRadius: 50,
                  //     color: Palette.shadowColor)
                ],
                color: chooseButtonColor(widget.buttonColor),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(widget.radius),
                  bottomLeft: Radius.circular(widget.radius),
                  topRight: widget.showError
                      ? const Radius.circular(0.0)
                      : Radius.circular(widget.radius),
                  topLeft: widget.showError
                      ? const Radius.circular(0.0)
                      : Radius.circular(widget.radius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Center(
                  child: widget.loading
                      ? const Center(
                          child: SizedBox(
                            width: 17.0,
                            height: 17.0,
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : AutoSizeText(
                          widget.buttonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.textColor,
                            fontWeight: widget.fontWeight,
                            fontSize: widget.size,
                          ),
                        ),
                ),
              )),
        ),
      ],
    );
  }
}

enum ButtonColor {
  primary,
  disable,
}

Color chooseButtonColor(ButtonColor buttonColor) {
  late Color color;

  switch (buttonColor) {
    case ButtonColor.primary:
      color = Palette.kSideMenuColor;
      break;

    case ButtonColor.disable:
      color = Palette.kGreyColor;
      break;
  }
  return color;
}
