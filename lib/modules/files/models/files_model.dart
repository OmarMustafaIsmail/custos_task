import 'package:equatable/equatable.dart';

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

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'],
      url: json['url'],
      size: json['size'],
      publicUrl: json['publicUrl']
    );
  }

  @override
  List<Object?> get props => [name,url];
}
