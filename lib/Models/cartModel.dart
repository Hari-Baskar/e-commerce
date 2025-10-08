class CartItem {
  String name;
  String description;
  double price;
  String image;
  String docId;
  int quantity;
  String category;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.docId,
    required this.category,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'quantity': quantity,
      'docId': docId,
      'category': category,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? 1,
      docId: map['docId'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
