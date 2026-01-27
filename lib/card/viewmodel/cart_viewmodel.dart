import 'package:flutter/material.dart';
import '../model/cart_item.dart';


class CartViewModel extends ChangeNotifier {
  final List<CartItem> items = [
    CartItem(
      image: 'assets/images/s-l1200-removebg-preview.png',
      title: 'Xbox series X',
      subtitle: '1TB',
      price: 570,
    ),
    CartItem(
      image: 'assets/images/s-l1200-removebg-preview.png',
      title: 'Wireless Controller',
      subtitle: 'Blue',
      price: 77,
    ),
    CartItem(
      image: 'assets/images/s-l1200-removebg-preview.png',
      title: 'Razer Kaira Pro',
      subtitle: 'Green',
      price: 153,
    ),
    CartItem(
      image: 'assets/images/s-l1200-removebg-preview.png',
      title: 'Wireless Controller',
      subtitle: 'Blue',
      price: 77,
    ),
    CartItem(
      image: 'assets/images/s-l1200-removebg-preview.png',
      title: 'Razer Kaira Pro',
      subtitle: 'Green',
      price: 153,
    ),
  ];

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get discount => subtotal * 0.4;
  double get delivery => 5;
  double get total => subtotal - discount + delivery;

  void increaseQty(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQty(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    items.remove(item);
    notifyListeners();
  }
}
