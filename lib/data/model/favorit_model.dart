class Favorit {
    final int id;
    final String itemId;
    final String userId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Item item;

    Favorit({
        required this.id,
        required this.itemId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.item,
    });

    factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
        id: json["id"],
        itemId: json["item_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        item: Item.fromJson(json["item"]),
    );

    

}

class Item {
    final int id;
    final String userId;
    final String name;
    final String description;
    final String category;
    final String condition;
    final String location;
    final String photo;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Item({
        required this.id,
        required this.userId,
        required this.name,
        required this.description,
        required this.category,
        required this.condition,
        required this.location,
        required this.photo,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
    );

        String get imageUrl =>
      photo.isNotEmpty
          ? "https://givebox.hanssu.my.id/storage/$photo"
          : "https://givebox.hanssu.my.id/assets/assets/img/error.jpg";

}
