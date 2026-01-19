import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> allShoes = [
    {
      'title': 'Nike Air Zoom',
      'subtitle': "Men's Shoe",
      'price': 320,
      'image':
      'https://tse4.mm.bing.net/th/id/OIP.oRWh5kKGOK9F17S8kiKo8QHaHa?pid=Api',
    },
    {
      'title': 'Nike Run Swift',
      'subtitle': "Women's Shoe",
      'price': 272,
      'image':
      'https://tse4.mm.bing.net/th/id/OIP.oRWh5kKGOK9F17S8kiKo8QHaHa?pid=Api',
    },
    {
      'title': 'Adidas Ultraboost',
      'subtitle': "Running Shoe",
      'price': 350,
      'image':
      'https://tse3.mm.bing.net/th/id/OIP.RpE2sYx1bYQyHcZ9l9GdRQHaHa?pid=Api',
    },
  ];

  List<Map<String, dynamic>> filteredShoes = [];

  SearchViewModel() {
    filteredShoes = allShoes;
  }

  void onSearch(String value) {
    filteredShoes = allShoes
        .where((shoe) => shoe['title'].toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
