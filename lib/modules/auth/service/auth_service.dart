
import 'package:custos_task/utils/network/local/secure_storage.dart';
import 'package:custos_task/utils/network/remote/dio_manager.dart';
import 'package:custos_task/utils/network/remote/end_points.dart';
import 'package:flutter/material.dart';



/// AuthService handles authentication-related operations such as login, registration, and logout.
/// It interacts with the backend via network requests using DioHelper.
class AuthService {


  /// Logs in a user with the provided email and password.
  ///
  /// [email] is the email address of the user.
  /// [password] is the user's password.
  /// Returns a map containing the server's response data or an error message.
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.loginUser,
        data: {
          'login': email,
          'password': password,
        },
      );

      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }



  /// Registers a new user with the provided email and password.
  ///
  /// [email] is the email address of the new user.
  /// [password] is the user's password.
  /// Returns a map containing the server's response data or an error message.
  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.registerUser,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data;
    } catch (e) {
      // Handle error
      return {'error': e.toString()};
    }
  }


  /// Logs out the currently authenticated user.
  ///
  /// Retrieves the user token from secure storage and sends a logout request to the server.
  /// Any errors encountered during the process are printed to the debug console.
  Future<void> logout()async{
    final SecureStorageService service = SecureStorageService();
    final token = await  service.getUserToken();
    try{
       await DioHelper.getData(
        url: ApiConstants.logoutUser,
        token: token
      );
    }catch(e){
    debugPrint(e.toString());
    }
  }
}
