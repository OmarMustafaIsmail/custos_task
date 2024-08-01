import 'package:equatable/equatable.dart';

/// UserModel represents a user with an ID and email address.
/// It extends Equatable to provide value equality based on its properties.

class UserModel extends Equatable {
  final String id;
  final String email;

  const UserModel({
    required this.id,
    required this.email,
  });


  /// Creates a UserModel instance from a JSON map.
  ///
  /// [json] is a map containing the user's data.
  /// Returns a new UserModel instance with data parsed from the JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['ownerId'],
        email: json['email'],
      );

  /// Converts the UserModel instance to a JSON map.
  ///
  /// Returns a map representation of the UserModel, with 'ownerId' and 'email' fields. To be used in saving user in secure storage
  Map<String, dynamic> toJson() => {
    'ownerId': id,
    'email': email,
  };


  // Equatable requires this method to compare instances based on their properties.
  @override
  List<Object?> get props => [id, email];
}
