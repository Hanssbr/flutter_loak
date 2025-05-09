class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? photo;
  final String role;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photo,
    required this.role,
  });
}
