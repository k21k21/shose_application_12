import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shose_application_12/User/Checkout/Model/checoutmodel.dart';

class CartViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveOrder(ShippingAddress address) async {
    try {
      String uid = _auth.currentUser!.uid; // جلب الـ UID بتاع المستخدم

      // إنشاء وثيقة جديدة جوه collection الـ Orders مربوطة بالـ User
      await _firestore.collection('Orders').add({
        'userId': uid, // الربط هنا
        ...address.toMap(),
        'status': 'Pending',
      });

      print("Order Saved Successfully");
    } catch (e) {
      print("Error saving order: $e");
    }
  }
}
