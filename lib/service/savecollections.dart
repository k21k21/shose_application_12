import 'package:cloud_firestore/cloud_firestore.dart';

class SaveService {
  Future<List<String>> getTitles() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('saves')
          .get();

      print("Docs fetched: ${snapshot.docs.length}");
      for (var doc in snapshot.docs) {
        print("Doc data: ${doc.data()}");
      }

      return snapshot.docs
          .map((doc) => doc.data()['title']?.toString() ?? '')
          .where((t) => t.isNotEmpty)
          .toList();
    } catch (e) {
      print("Error fetching titles: $e");
      return [];
    }
  }
}
