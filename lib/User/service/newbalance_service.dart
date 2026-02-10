import 'package:cloud_firestore/cloud_firestore.dart';

class NewbalanceService {
  /// جلب المنتجات من brand محدد
  Future<List<Map<String, dynamic>>> getBrandProductsnewbalance({
    required String brandDoc,
    required String collectionName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .doc('newbalance')
          .collection('New Balance 2002R')
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
