import 'package:cloud_firestore/cloud_firestore.dart';

class Allservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // البراندات
  final List<String> brands = [
    'asics',
    'timberland',
    'adidas',
    'crocs',
    'newbalance',
    'nike',
  ];

  // الكوليكشنات اللي جوه كل براند
  final List<String> collections = [
    'Asics Gel',
    'Timberland 6',
    'Crocs',
    'New Balance 2002R',
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
    'Adidas Spezial',
  ];

  /// يجمع كل المنتجات
  Future<List<Map<String, dynamic>>> getAllShoes() async {
    List<Map<String, dynamic>> allProducts = [];

    try {
      for (String brand in brands) {
        for (String collection in collections) {
          QuerySnapshot snapshot = await _firestore
              .collection('shoes')
              .doc(brand)
              .collection(collection)
              .get();

          for (var doc in snapshot.docs) {
            allProducts.add({
              'brand': brand,
              'category': collection,
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            });
          }
        }
      }
    } catch (e) {
      print('🔥 Firestore Error: $e');
    }

    return allProducts;
  }
}
