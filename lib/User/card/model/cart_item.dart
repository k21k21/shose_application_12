class CartItem {
  final String image;
  final String title;
  final String subtitle;
  final double price;
  int quantity;

  CartItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
  });
}
