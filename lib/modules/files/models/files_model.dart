import 'package:equatable/equatable.dart';

class FileModel extends Equatable{
  final String name;
  final String url;

  const FileModel({
    required this.name,
    required this.url,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  @override
  List<Object?> get props => [name,url];
}
