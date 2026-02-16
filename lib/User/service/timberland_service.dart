import 'package:cloud_firestore/cloud_firestore.dart';

class TimberlandService {
  /// جلب المنتجات من brand محدد
  Future<List<Map<String, dynamic>>> getBrandProducts({
    required String brandDoc,
    required String collectionName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .doc('timberland')
          .collection('Timberland 6')
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
