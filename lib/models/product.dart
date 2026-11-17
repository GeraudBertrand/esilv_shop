class Product {
  final int id;
  final String title;
  final String description;
  final int price;
  final String category;
  final String image;
  final num rate;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rate
  });

  String getPrice(){
    return "${(price/100).toStringAsFixed(2)}€";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
      'rate': rate
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String? ?? "",
      description: map['description'] as String,
      price: ((map['price'] as num) * 100).round(),
      category: map['category'] as String,
      image: map['image'] as String? ?? "",
      rate: map['rating']['rate'] as num
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;


}