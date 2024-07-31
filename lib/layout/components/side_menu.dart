import 'package:custos_task/layout/components/side_menu_tab.dart';
import 'package:custos_task/layout/provider/app_layout_provider.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      color: Palette.kSideMenuColor,
      child: Consumer<AppLayoutProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                InkWell(
                  onTap: () => value.selectScreen('dashboard'),
                  child: SideMenuTab(
                      label: 'DASHBOARD',
                      icon: Icons.home_filled,
                      isSelected: value.selectedScreen == 'dashboard'),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                  onTap: () => value.selectScreen('files'),
                  child: SideMenuTab(
                      label: 'FILES',
                      icon: Icons.file_copy,
                      isSelected: value.selectedScreen == 'files'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
