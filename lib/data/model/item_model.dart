class Items {
  final int id;
  final String? userId;
  final String? name;
  final String? description;
  final String? category;
  final String? condition;
  final String? location;
  final String? photo;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  Items({
    required this.id,
    this.userId,
    this.name,
    this.description,
    this.category,
    this.condition,
    this.location,
    this.photo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    condition: json["condition"],
    location: json["location"],
    photo: json["photo"],
    status: json["status"],
    createdAt:
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt:
        json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "description": description,
    "category": category,
    "condition": condition,
    "location": location,
    "photo": photo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };

  String get photoUrl =>
      photo != null && photo!.isNotEmpty
          ? "https://givebox.hanssu.my.id/storage/$photo"
          : "https://givebox.hanssu.my.id/assets/assets/img/error.jpg";
}

class User {
  final int id;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? emailVerifiedAt;
  final dynamic photo;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt:
        json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : null,
    phone: json["phone"],
    photo: json["photo"],
    role: json["role"],
    createdAt:
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt:
        json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "phone": phone,
    "photo": photo,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
