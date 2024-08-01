import 'package:equatable/equatable.dart';

/// FileModel represents a file with its name, URL, size, and public URL.
/// It extends Equatable to provide value equality based on its properties.
class FileModel extends Equatable{
  final String name;
  final String url;
  final int size;
  final String publicUrl;

  const FileModel({
    required this.name,
    required this.url,
    required this.size,
    required this.publicUrl
  });


  /// Creates a FileModel instance from a JSON map.
  ///
  /// [json] is a map containing the file's data.
  /// Returns a new FileModel instance with data parsed from the JSON map
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'],
      url: json['url'],
      size: json['size'],
      publicUrl: json['publicUrl']
    );
  }

  // Equatable requires this method to compare instances based on their properties.
  @override
  List<Object?> get props => [name,url];
}
