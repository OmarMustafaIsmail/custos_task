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
}
