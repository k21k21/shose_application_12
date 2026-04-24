class CartItem {
  final String img;
  final String name;
  final String brand;
  final double price;
  int quantity;

  CartItem({
    required this.img,
    required this.name,
    required this.brand,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
    'img': img,
    'name': name,
    'brand': brand,
    'price': price,
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    img: json['img'],
    name: json['name'],
    brand: json['brand'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'],
  );
}
