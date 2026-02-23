import 'package:flutter/material.dart';
import '../../service/allservice.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  bool isLoadingData = false;

  List<Map<String, dynamic>> allShoes = [];
  List<Map<String, dynamic>> filteredShoes = [];

  SearchViewModel() {
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    isLoadingData = true;
    notifyListeners();

    try {
      // Create an instance of Allservice
      Allservice service = Allservice();

      // Fetch all shoes from Firestore
      allShoes = await service.getAllShoes();

      // Optional: map to only the fields you want
      allShoes = allShoes.map((shoe) {
        return {
          'title': shoe['name'] ?? '',
          'subtitle': shoe['brand'] ?? '',
          'price': shoe['price'] is int
              ? shoe['price']
              : int.tryParse(shoe['price'].toString()) ?? 0,
          'image': shoe['img'] ?? '',
        };
      }).toList();

      // Initially, filtered list = all shoes
      filteredShoes = List.from(allShoes);
      filteredShoes.shuffle();
    } catch (e) {
      print('Error fetching shoes: $e');
    }

    isLoadingData = false;
    notifyListeners();
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      filteredShoes = List.from(allShoes);
    } else {
      filteredShoes = allShoes
          .where((shoe) =>
          shoe['title'].toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    filteredShoes.shuffle();
    notifyListeners();
  }
}
