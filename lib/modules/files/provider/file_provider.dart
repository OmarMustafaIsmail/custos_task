import 'dart:io';
import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/modules/files/service/file_service.dart';
import 'package:flutter/foundation.dart';

class FileProvider extends ChangeNotifier {
  final FileService _fileService = FileService();
  List<FileModel> _files = [];

  List<FileModel> get files => _files;

  Future<void> uploadFile(File file) async {
    try {
      await _fileService.uploadFile(file);
      await _fetchFiles();
    } catch (e) {
      debugPrint('Error uploading file: $e');
    }
  }

  Future<void> _fetchFiles() async {
    try {
      _files = await _fileService.listFiles();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching files: $e');
    }
  }

  Future<void> initialize() async {
    await _fetchFiles();
  }
}
