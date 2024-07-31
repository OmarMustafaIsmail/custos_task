// services/auth_service.dart

import 'package:custos_task/utils/network/remote/dio_manager.dart';
import 'package:custos_task/utils/network/remote/end_points.dart';

class AuthService {
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
}
