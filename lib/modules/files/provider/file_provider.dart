import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/modules/files/service/file_service.dart';
import 'package:custos_task/shared/custom_snakbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

import '../../../utils/palette.dart';

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

  Future<void> uploadFile(String fileName, Uint8List fileBytes,BuildContext context) async {
    _setUploading(true);
    final result = await _fileService.uploadFile(fileName, fileBytes);
    _setUploading(false);
    if (result != null) {
      debugPrint("File uploaded successfully: $result");
      // Fetch user files after upload
      if(context.mounted) {
        await fetchUserFiles(context);
      }
    } else {
      if (context.mounted) {
        showFloatingSnackBar(
            context, 'File upload failed', Palette.kDangerRedColor,textColor:Palette.kOffWhiteColor);
      }
      debugPrint("File upload failed");
    }
  }

  Future<void> fetchUserFiles(context) async {
    try {
      _files = await _fileService.listFiles();
      _isInitialized = true;
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


  /// This function takes a byte value and converts it into a string representation
  /// with the most suitable unit (Bytes, KB, MB, GB, TB). It uses a logarithmic
  /// scale to determine the appropriate unit and formats the value to two decimal places.
  ///
  /// [bytes] is the number of bytes to be converted.
  /// Returns a formatted string representing the byte value with its unit.
  String formatBytes(int bytes,) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    final i = (bytes > 0) ? (math.log(bytes) / math.log(1024)).floor() : 0;
    final value = bytes / math.pow(1024, i);
    return "${value.toStringAsFixed(2)} ${suffixes[i]}";
  }



  /// Determines if a file path refers to an image file based on its extension.
  ///
  /// This function checks if the file extension of the given file path matches
  /// a predefined list of common image file extensions. It is case-insensitive.
  ///
  /// [filePath] is the path of the file to be checked.
  /// Returns `true` if the file extension matches one of the image types, otherwise `false`.
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

  Future<void> initialize(BuildContext context) async {
    if (!_isInitialized) {
      await fetchUserFiles(context);
      _isInitialized = true;
    }
  }
}
