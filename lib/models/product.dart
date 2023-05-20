class Product {
  final String? id;
  final String name;
  final String brand;
  final String description;
  final num price;
  final num discount;
  final num splPrice;
  final List<String> image;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.discount,
    required this.description,
    required this.price,
    required this.splPrice,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json, String sId) {
    return Product(
      id: sId,
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      price: json['price'],
      discount: json['discount'],
      splPrice: json['splPrice'],
      image: (json['image'] as List).map((e) => e.toString()).toList(),
    );
  }
}
