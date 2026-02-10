import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/cart_viewmodel.dart';
import 'widgets/cart_itemcard.dart';
import 'widgets/summary_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double dragX = 0;
  late double width;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 150.h),
              child: ListView.builder(
                padding: EdgeInsets.all(width * 0.04),
                itemCount: vm.items.length,
                itemBuilder: (context, index) {
                  return CartItemCard(item: vm.items[index]);
                },
              ),
            ),

            /// Bottom Sheet
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.25,
              maxChildSize: 0.6,
              builder: (context, controller) {
                return Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        /// Summary
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.06,
                          ),
                          child: Column(
                            children: [
                              SummaryRow(
                                'Subtotal',
                                '\$${vm.subtotal.toStringAsFixed(2)}',
                              ),
                              SummaryRow('Delivery', '\$${vm.delivery}'),
                              const SummaryRow('Discount', '40%'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Checkout Button
                        _checkoutButton(vm, width),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutButton(CartViewModel vm, double width) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        minWidth: width,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.black,
        onPressed: () {},
        child: Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
            fontFamily: "Roboto_Condensed",
          ),
        ),
      ),
    );
  }
}
