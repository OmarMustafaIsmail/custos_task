import 'package:custos_task/layout/components/side_menu.dart';
import 'package:custos_task/layout/provider/app_layout_provider.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:custos_task/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppLayoutScreen extends StatelessWidget {
  const AppLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = Responsive.isDesktop(context);

    return PopScope(
    canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: SvgPicture.asset(
            'assets/icons/custos_logo.svg',
            colorFilter: const ColorFilter.mode(
              Palette.kWhiteColor,
              BlendMode.srcATop,
            ),
            height: height * 0.05,
            width: width * 0.05,
          ),
          backgroundColor: Palette.kAppBarColor,
          iconTheme: const IconThemeData(color: Palette.kWhiteColor),
        ),
        drawer: !isDesktop
            ? const SizedBox(
                width: 250,
                child: SideMenuWidget(),
              )
            : null,
        body: SafeArea(
          child: Row(
            children: [
              if (isDesktop)
                const Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: SideMenuWidget(),
                  ),
                ),
              Expanded(
                flex: 10,
                child: Consumer<AppLayoutProvider>(
                  builder: (context, navigationProvider, child) {
                    return navigationProvider.getScreenWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
