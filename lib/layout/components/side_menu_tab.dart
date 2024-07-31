import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';

class SideMenuTab extends StatelessWidget {
  const SideMenuTab(
      {super.key,
      required this.label,
      required this.icon,
      required this.isSelected});
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? Palette.kOffWhiteColor : Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.005),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? Palette.kBlackColor : Palette.kOffWhiteColor,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color:
                    isSelected ? Palette.kBlackColor : Palette.kOffWhiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
