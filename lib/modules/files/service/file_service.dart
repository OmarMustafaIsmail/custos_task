
import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/utils/network/local/secure_storage.dart';
import 'package:custos_task/utils/network/remote/dio_manager.dart';
import 'package:custos_task/utils/network/remote/end_points.dart';
import 'package:custos_task/utils/network/remote/fetch_exception.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';



/// FileService handles file-related operations such as uploading, listing, and downloading files.
/// It interacts with the backend via network requests using DioHelper and manages user tokens with SecureStorageService.
class FileService {
  final SecureStorageService _secureStorageService = SecureStorageService();


  /// Uploads a file to the server.
  ///
  /// [fileName] is the name of the file being uploaded.
  /// [fileBytes] is the byte data of the file.
  /// Returns the URL of the uploaded file if successful, or throws a FetchException if an error occurs.
  Future<String?> uploadFile(String fileName, Uint8List fileBytes) async {
    final user = await _secureStorageService.getUser();
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(fileBytes, filename: fileName),
      });

      Response response = await DioHelper.postData(
          url: "${ApiConstants.uploadFiles}/${user!.id}/$fileName",
          data: formData,
          token: await _secureStorageService.getUserToken());

      if (response.statusCode == 200) {
        return response.data['fileURL'];
      } else {
        throw const FetchException("Failed to upload file");
      }
    } catch (e) {
      debugPrint("Error uploading file: $e");
      throw const FetchException("Failed to upload file");
    }
  }



  /// Lists all files for the current user.
  ///
  /// Retrieves the list of files from the server and converts the response into a list of FileModel objects.
  /// Returns a list of FileModel instances if successful, or throws an exception if an error occurs.
  Future<List<FileModel>> listFiles() async {
    final token = await _secureStorageService.getUserToken();
    final user = await _secureStorageService.getUser();

    try {
      final response = await DioHelper.getData(
        url: "${ApiConstants.getFiles}/${user!.id}",
        token: token,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((file) => FileModel.fromJson(file)).toList();
      } else {
        throw Exception('Failed to load files');
      }
    } catch (e) {
      debugPrint('Error listing file: $e');
      throw FetchException(e.toString());
    }
  }


  /// Downloads a file for the current user.
  ///
  /// [fileName] is the name of the file to be downloaded.
  /// Uses the FileSaver package to save the file locally from the provided URL.
  /// Any errors encountered during the download process are printed to the debug console.
  Future<void> downloadFile(String fileName) async {
    final token = await _secureStorageService.getUserToken();
    final user = await _secureStorageService.getUser();
    try {
      await FileSaver.instance.saveFile(
        name: fileName,
        link: LinkDetails(
          link: "${ApiConstants.downloadFiles}/${user!.id}/$fileName",
          headers: {
            'user-token': token!,
          },
        ),
      );
    } catch (e) {
      debugPrint('Error downloading file: $e');
    }
  }
}
