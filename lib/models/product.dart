class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image});

  String getPrice(){
    return "${price.toStringAsFixed(2)}€";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['name'] as String? ?? "",
      description: map['description'] as String,
      price: map['price'] as num,
      category: map['category'] as String,
      image: map['image'] as String? ?? "",
    );
  }

}