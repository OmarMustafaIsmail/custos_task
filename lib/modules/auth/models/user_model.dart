import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;

  const UserModel({
    required this.id,
    required this.email,
  });


  // Convert json to user model
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['ownerId'],
        email: json['email'],
      );

  // Convert a User object to a Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
  };

  @override
  List<Object?> get props => [id, email];
}
