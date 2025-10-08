class Product {
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final String docId;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.docId,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: data['name'] ?? '',
      description: data['des'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      docId: data['docId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'docId': docId,
    };
  }
}
