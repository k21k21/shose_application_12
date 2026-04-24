import 'package:cloud_firestore/cloud_firestore.dart';

class NikeService {
  final List<String> nikeCollections = [
    'Air Jordan 1 High',
    'Air Jordan 1 Low',
    'Air Jordan 11',
    'Air Jordan 3',
    'Air Jordan 4',
    'Air Jordan 5 OG',
    'Air Max Plus TN',
    'Jordan Jumpman Jack',
    'Nike Air Force 1 Low',
    'Nike Air Max 95',
    'Nike P-6000 WMNS',
    'Nike Shox',
    'Travis Scott',
  ];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // جلب كل منتجات Nike
  Future<List<Map<String, dynamic>>> getAllNikeProducts() async {
    try {
      List<Map<String, dynamic>> allProducts = [];

      for (String collectionName in nikeCollections) {
        final snapshot = await firestore
            .collection('shoes')
            .doc('nike')
            .collection(collectionName)
            .get();

        for (var doc in snapshot.docs) {
          allProducts.add({...doc.data(), 'model': collectionName});
        }
      }

      return allProducts;
    } catch (e) {
      print('Error fetching Nike products: $e');
      return [];
    }
  }

  // جلب منتجات Nike لكوليكشن محدد
  Future<List<Map<String, dynamic>>> getNikeProductsByCollection(
    String collectionName,
  ) async {
    try {
      final snapshot = await firestore
          .collection('shoes')
          .doc('nike')
          .collection(collectionName)
          .get();

      List<Map<String, dynamic>> collectionProducts = [];
      for (var doc in snapshot.docs) {
        collectionProducts.add({...doc.data(), 'model': collectionName});
      }

      return collectionProducts;
    } catch (e) {
      print('Error fetching Nike collection $collectionName: $e');
      return [];
    }
  }
}
