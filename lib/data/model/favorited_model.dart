class Favorited {
  final int? id;
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

  Favorited({
    this.id,
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
  });

  factory Favorited.fromJson(Map<String, dynamic> json) => Favorited(
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
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  };
}
