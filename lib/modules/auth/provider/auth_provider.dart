import 'package:custos_task/modules/auth/models/user_model.dart';
import 'package:custos_task/modules/auth/service/auth_service.dart';
import 'package:custos_task/shared/custom_snakbar.dart';
import 'package:custos_task/utils/network/local/secure_storage.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:custos_task/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// AuthProvider is responsible for managing authentication-related operations
/// including login, registration, and logout. It communicates with the AuthService
/// to perform these actions and updates the authentication state accordingly.
class AuthProvider with ChangeNotifier {
  final SecureStorageService _secureStorage = SecureStorageService();
  final AuthService _authService = AuthService();
  late bool _isAuthenticated = false; // Tracks whether the user is authenticated
  String _userToken = ''; // Stores the user's authentication token
  bool _isLoadingLogin = false; // Tracks the loading state for login
  bool _isLoadingRegister = false; // Tracks the loading state for registration
  bool _isInitialized = false; // Tracks whether the initialization process is complete

  // Getters to expose loading states and initialization status
  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLoadingRegister => _isLoadingRegister;
  bool get isInitialized => _isInitialized;
  bool get isAuthenticated => _isAuthenticated;

  /// Initializes the authentication state by checking for a user token.
  ///
  /// Retrieves the user token from secure storage. If a token is found, it sets
  /// the user as authenticated, updates the internal state, and navigates to the layout page.
  /// If no token is found, it navigates to the login page.
  /// This function is asynchronous and uses the `await` keyword to handle token retrieval.
  Future<void> init() async {
    debugPrint("started init");
    final token = await _secureStorage.getUserToken();
    debugPrint(token.toString());
    if (token != null) {
      // User is authenticated, redirect to layout
      _isAuthenticated = true;
      _userToken = token;
      router.go('/layout');
    } else {
      // User is not authenticated, redirect to login page
      router.go('/login');
    }
    _isInitialized = true; // Mark initialization as complete
    notifyListeners();
  }

  /// Sets the loading state for either login or registration.
  ///
  /// Updates the loading state based on the `login` flag. If `login` is true,
  /// it updates `_isLoadingLogin`. Otherwise, it updates `_isLoadingRegister`.
  void _setLoading(bool value, {bool login = true}) {
    if (login) {
      _isLoadingLogin = value;
    } else {
      _isLoadingRegister = value;
    }
    notifyListeners();
  }

  /// Handles user login.
  ///
  /// Sends a login request to the AuthService and processes the response. If login is successful,
  /// it saves the user token and user data to secure storage and updates the authentication status.
  /// Displays an error message if login fails.
  Future<void> login(String email, String password, {required BuildContext context}) async {
    debugPrint(_userToken);
    debugPrint(isAuthenticated.toString());
    _setLoading(true);
    final result = await _authService.login(email, password);
    if (result.containsKey('user-token')) {
      _userToken = result['user-token'];
      _isAuthenticated = true;
      UserModel user = UserModel.fromJson(result);
      await _secureStorage.saveUserToken(_userToken);
      await _secureStorage.saveUser(user);
      var userAfter = await _secureStorage.getUser();
      debugPrint(userAfter.toString());
      _setLoading(false);
      notifyListeners();
    } else {
      // Handle login error
      debugPrint("error is ${result['message'].toString()}");
      _setLoading(false);
      if (context.mounted) {
        showFloatingSnackBar(
          context,
          result['message'],
          Palette.kDangerRedColor,
          textColor: Palette.kOffWhiteColor,
        );
      }
      notifyListeners();
    }
  }

  /// Handles user registration.
  ///
  /// Sends a registration request to the AuthService and processes the response. If registration is successful,
  /// it automatically logs in the user. Displays an error message if registration fails.
  Future<void> register(String email, String password, {required BuildContext context}) async {
    _setLoading(true, login: false);
    final result = await _authService.register(email, password);
    if (result.containsKey('created')) {
      // Handle successful registration
      if (context.mounted) {
        await login(email, password, context: context);
      }
      _setLoading(false, login: false);
    } else {
      // Handle registration error
      debugPrint("error is ${result['message'].toString()}");
      _setLoading(false, login: false);
      if (context.mounted) {
        showFloatingSnackBar(
          context,
          result['message'],
          Palette.kDangerRedColor,
          textColor: Palette.kOffWhiteColor,
        );
      }
    }
  }

  /// Handles user logout.
  ///
  /// Clears the authentication token, updates the authentication status, and logs out the user.
  /// It also removes the token and user data from secure storage.
  Future<void> logout() async {
    _userToken = '';
    _isAuthenticated = false;
    await _authService.logout();
    await _secureStorage.deleteUserToken();
    await _secureStorage.deleteUser();
    notifyListeners();
  }

  /// Validates if the provided string is a valid email address.
  ///
  /// Uses a regular expression to check the format of the email address.
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
