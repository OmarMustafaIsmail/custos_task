import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/modules/files/service/file_service.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

class FileProvider with ChangeNotifier {
  final FileService _fileService = FileService();
  bool _isUploading = false;
  bool _isInitialized = false;
  List<FileModel> _files = [];

  bool get isUploading => _isUploading;
  bool get isInitialized => _isInitialized;
  List<FileModel> get files => _files;

  void _setUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  Future<void> uploadFile(String fileName, Uint8List fileBytes) async {
    _setUploading(true);
    final result = await _fileService.uploadFile(fileName, fileBytes);
    _setUploading(false);
    if (result != null) {
      debugPrint("File uploaded successfully: $result");
      // Fetch user files after upload
      await fetchUserFiles();
    } else {
      debugPrint("File upload failed");
    }
  }

  Future<void> fetchUserFiles() async {
    try {
      _files = await _fileService.listFiles();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user files: $e");
    }
  }
  Future<void> downloadFile({required String fileName}) async {
    try {
     await _fileService.downloadFile(fileName);
      notifyListeners();
    } catch (e) {
      debugPrint("Error downloadingFile: $e");
    }
  }

  String formatBytes(int bytes,) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    final i = (bytes > 0) ? (math.log(bytes) / math.log(1024)).floor() : 0;
    final value = bytes / math.pow(1024, i);
    return "${value.toStringAsFixed(2)} ${suffixes[i]}";
  }
  bool isImageFile(String filePath) {
    // List of image file extensions
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];

    // Get file extension
    final extension = filePath.split('.').last.toLowerCase();

    // Check if the extension is in the list of image extensions
    if (imageExtensions.contains(extension)) {
      return true;
    }

    return false;
  }

  Future<void> initialize() async {
    if (!_isInitialized) {
      await fetchUserFiles();
      _isInitialized = true;
    }
  }
}
