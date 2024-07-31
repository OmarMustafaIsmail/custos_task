import 'package:flutter/material.dart';

class Responive {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 810;
  bool isTab(BuildContext context) =>
      MediaQuery.of(context).size.width >= 810 &&
      MediaQuery.of(context).size.width < 1100;
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
