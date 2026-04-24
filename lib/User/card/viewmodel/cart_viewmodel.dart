import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shose_application_12/User/card/model/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItem> cartItems = [];
  double delivery = 50;
  String userEmail;

  CartViewModel({required this.userEmail});

  void addToCart(CartItem item) {
    cartItems.add(item);
    saveCart();
    notifyListeners();
  }

  void increaseQty(CartItem item) {
    item.quantity++;
    saveCart();
    notifyListeners();
  }

  void decreaseQty(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      saveCart();
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    saveCart();
    notifyListeners();
  }

  double get price =>
      cartItems.fold(0, (total, item) => total + item.price * item.quantity);

  Future<void> initCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('cart_$userEmail');

    if (data != null) {
      cartItems = data.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    }

    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = cartItems.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList('cart_$userEmail', data);
  }

  bool _isLoaded = true;
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('cart_$userEmail');

    if (data != null) {
      cartItems = data.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    } else {
      cartItems = [];
    }

    notifyListeners();
  }

  void setUser(String newUserId) {
    userEmail = newUserId;
    cartItems = []; // 🔥 امسح القديم
    loadCart();
  }
}
