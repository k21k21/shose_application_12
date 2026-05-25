import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shose_application_12/User/Checkout/view/OrderCompleted.dart';

class Checkout extends StatefulWidget {
  final List<dynamic> cartItems;
  final double totalPrice;

  const Checkout({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<Checkout> createState() => _InformationStepState();
}

class _InformationStepState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final buildingController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Shipping Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto_Condensed",
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              _buildTextField(
                label: "Full Name (Double)",
                hint: "Enter your first and last name",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Full name is required";
                  if (value.trim().split(RegExp(r'\s+')).length < 2) {
                    return "Please enter at least two names";
                  }
                  return null;
                },
              ),

              _buildTextField(
                label: "City",
                hint: "Cairo / Giza",
                controller: cityController,
                validator: (value) => (value == null || value.isEmpty)
                    ? "City is required"
                    : null,
              ),

              _buildTextField(
                label: "Street Address",
                hint: "Enter your full address",
                controller: addressController,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Address is required"
                    : null,
              ),

              _buildTextField(
                label: "Building Number",
                hint: "15 / 13",
                controller: buildingController,
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Building number is required"
                    : null,
              ),

              _buildTextField(
                label: "Phone Number",
                hint: "01xxxxxxxxx",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Phone number is required";
                  if (value.length != 11) return "Must be exactly 11 digits";
                  if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
                    return "Enter a valid Egyptian phone number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 40.h),

              // زرار التأكيد النهائي - مباشر للكاش فقط
              Container(
                width: double.infinity,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // رفع البيانات لـ Firebase
                        await FirebaseFirestore.instance
                            .collection('Orders')
                            .add({
                              "Full Name": nameController.text.trim(),
                              "City": cityController.text.trim(),
                              "Street Address": addressController.text.trim(),
                              "Phone Number": phoneController.text.trim(),
                              "Order Date": DateTime.now().toString(),
                              "status": "Pending",

                              // البيانات اللي استقبلناها من الـ Constructor
                              "items": widget.cartItems,
                              "totalAmount": widget.totalPrice,
                            });

                        // تنظيف السلة بعد نجاح الأوردر (اختياري)
                        // Provider.of<CartViewModel>(context, listen: false).cartItems.clear();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderCompletedPage(),
                          ),
                        );
                      } catch (e) {
                        print("Error: $e");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Roboto_Condensed",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto_Condensed",
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            style: const TextStyle(fontFamily: "Roboto_Condensed"),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontFamily: "Roboto_Condensed"),
              errorStyle: const TextStyle(fontFamily: "Roboto_Condensed"),
              counterText: "",
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 18.h,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
