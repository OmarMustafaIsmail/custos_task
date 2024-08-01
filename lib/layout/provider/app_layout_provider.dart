import 'package:custos_task/modules/dashboard/screens/dashboard_screen.dart';
import 'package:custos_task/modules/files/screens/files_screen.dart';
import 'package:flutter/material.dart';

class AppLayoutProvider with ChangeNotifier {
  String _selectedScreen = 'files';

  String get selectedScreen => _selectedScreen;

  void selectScreen(String screen) {
    _selectedScreen = screen;
    notifyListeners();
  }

  Widget getScreenWidget() {
    switch (_selectedScreen) {
      case 'dashboard':
        return const DashboardScreen();
      case 'files':
        return const FilesScreen();
      // Add more cases for other screens
      default:
        return const Center(child: Text('Screen not found'));
    }
  }
}
