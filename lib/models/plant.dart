class Plant {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String category;
  final int quantity;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    this.quantity = 1,
  });

  factory Plant.fromJson(Map<String, dynamic> json, String category) {
    return Plant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      category: category,
    );
  }

  Plant copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    double? price,
    String? category,
    int? quantity,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}
