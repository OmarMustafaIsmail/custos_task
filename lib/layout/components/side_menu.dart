import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/layout/components/side_menu_tab.dart';
import 'package:custos_task/layout/provider/app_layout_provider.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: Image.asset('assets/images/user.png'),
                //     ),
                //   ],
                // ),
                // InkWell(
                //   onTap: () => value.selectScreen('dashboard'),
                //   child: SideMenuTab(
                //       label: 'DASHBOARD',
                //       icon: Icons.home_filled,
                //       isSelected: value.selectedScreen == 'dashboard'),
                // ),
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

                const Spacer(),
                Padding(
                  padding:  EdgeInsets.only(bottom: height * 0.1),
                  child: InkWell(
                    onTap: ()=>context.read<AuthProvider>().logout(),
                    child: const Row(
                      children: [
                        Icon(Icons.logout,color: Palette.kOffWhiteColor,),
                        SizedBox(width: 10,),
                        AutoSizeText('LOGOUT',style: TextStyle(color: Palette.kOffWhiteColor),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
