class Product {
  final String name;

  Product({required this.name});

  factory Product.fromJson(String name) {
    return Product(
      name: name,
    );
  }
}
