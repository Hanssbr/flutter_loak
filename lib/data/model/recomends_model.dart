class RecomendItems {
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
    final String? favoritesCount;

    RecomendItems({
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
        this.favoritesCount,
    });

    factory RecomendItems.fromJson(Map<String, dynamic> json) => RecomendItems(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        condition: json["condition"],
        location: json["location"],
        photo: json["photo"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        favoritesCount: json["favorites_count"],
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

    String get imageUrl =>
      photo != null && photo!.isNotEmpty
          ? "https://givebox.hanssu.my.id/storage/$photo"
          : "https://givebox.hanssu.my.id/assets/assets/img/error.jpg";
}



