import 'package:cloud_firestore/cloud_firestore.dart';

class BapeService {
  /// جلب المنتجات من brand محدد
  Future<List<Map<String, dynamic>>> getBrandProductsbape({
    required String brandDoc,
    required String collectionName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .doc('Bape')
          .collection('BAPE')
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
