import 'dart:convert';

import 'package:custos_task/modules/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserToken(String token) async {
    await _storage.write(key: 'userToken', value: token);
  }

  Future<String?> getUserToken() async {
    return await _storage.read(key: 'userToken');
  }

  Future<void> deleteUserToken() async {
    await _storage.delete(key: 'userToken');
  }

  Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await _storage.write(key: 'user', value: userJson);
  }

  Future<UserModel?> getUser() async {
    final userJson = await _storage.read(key: 'user');
    if (userJson != null) {
      debugPrint(userJson.toString());
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: 'user');
  }
}
