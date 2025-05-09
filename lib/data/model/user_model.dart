import 'package:project_sem2/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    String? photo,
    required String role,
  }) : super(
         id: id,
         name: name,
         email: email,
         phone: phone,
         photo: photo,
         role: role,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      photo: json['photo'],
      email: json['email'],
      role: json['role'],
    );
  }

  String get photoUrl =>
      photo != null && photo!.isNotEmpty
          ? "https://givebox.hanssu.my.id/storage/$photo"
          : "https://givebox.hanssu.my.id/storage/profile_photos/idGgSi0e17hfjms1HrKoEjbL9hx1SHQ368ZfRBD9.jpg";
}
