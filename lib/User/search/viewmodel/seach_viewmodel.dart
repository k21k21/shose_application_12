import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> allShoes = [
    {
      'title': 'Nike Air Zoom',
      'subtitle': "Men's Shoe",
      'price': 320,
      'image': 'assets/images/s-l1200-removebg-preview.png',
    },
    {
      'title': 'Nike Air Zoom',
      'subtitle': "Men's Shoe",
      'price': 320,
      'image': 'assets/images/s-l1200-removebg-preview.png',
    },
    {
      'title': 'Nike Air Zoom',
      'subtitle': "Men's Shoe",
      'price': 320,
      'image': 'assets/images/s-l1200-removebg-preview.png',
    },
  ];

  List<Map<String, dynamic>> filteredShoes = [];

  SearchViewModel() {
    filteredShoes = allShoes;
  }

  void onSearch(String value) {
    filteredShoes = allShoes
        .where(
          (shoe) => shoe['title'].toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }
}
