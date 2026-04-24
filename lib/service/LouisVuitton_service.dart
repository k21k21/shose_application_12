import 'package:cloud_firestore/cloud_firestore.dart';

class LouisvuittonService {
  /// جلب المنتجات من brand محدد
  Future<List<Map<String, dynamic>>> getBrandProductLouisvuitton({
    required String brandDoc,
    required String collectionName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .doc('Louis Vuitton')
          .collection('LV Trainers')
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
