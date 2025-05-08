import 'package:project_sem2/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String role,
  }) : super(id: id, name: name, email: email,phone:phone, role: role);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
