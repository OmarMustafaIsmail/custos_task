import 'dart:io';
import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/utils/network/remote/dio_manager.dart';
import 'package:custos_task/utils/network/remote/end_points.dart';
import 'package:custos_task/utils/network/remote/fetch_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FileService {

  Future<void> uploadFile(File file) async {

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.postData(
        url: ApiConstants.uploadFiles,
        data: formData,
        contentType: 'multipart/form-data',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      debugPrint('Error uploading file: $e');
      throw FetchException(e.toString());
    }
  }

  Future<List<FileModel>> listFiles() async {

    try {
      final response = await DioHelper.getData(url: ApiConstants.uploadFiles);

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
}
