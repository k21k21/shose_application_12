import 'package:flutter/material.dart';

class CardViewModel extends ChangeNotifier {
  final List<ShoeItem> allShoes = [
    ShoeItem(
      title: 'Nike Air Zoom',
      subtitle: "Men's Shoe, UK 10",
      price: 320,
      image: 'assets/images/s-l1200-removebg-preview.png',
    ),
    ShoeItem(
      title: 'Nike Run Swift',
      subtitle: "Women's Shoe, UK 08",
      price: 272,
      image: 'assets/images/s-l1200-removebg-preview.png',
    ),
  ];

  final Map<ShoeItem, int> quantities = {};

  CardViewModel() {
    for (var shoe in allShoes) {
      quantities[shoe] = 1;
    }
  }

  void increaseQuantity(ShoeItem shoe) {
    quantities[shoe] = (quantities[shoe] ?? 1) + 1;
    notifyListeners();
  }

  void decreaseQuantity(ShoeItem shoe) {
    if ((quantities[shoe] ?? 1) > 1) {
      quantities[shoe] = (quantities[shoe] ?? 1) - 1;
      notifyListeners();
    }
  }

  int getQuantity(ShoeItem shoe) => quantities[shoe] ?? 1;
}

class ShoeItem {
  final String title;
  final String subtitle;
  final int price;
  final String image;

  ShoeItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
  });
}
