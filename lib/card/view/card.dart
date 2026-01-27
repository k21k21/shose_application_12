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
  double _dragPosition = 0;
  bool _completed = false;
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
                            color: Colors.black,
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
      padding: EdgeInsets.all(width * 0.04),
      child: SizedBox(
        width: width,
        height: 60.h,
        child: Stack(
          children: [
            Container(
              width: width,
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xffeeeeee),
                borderRadius: BorderRadius.circular(30.r),
              ),
              alignment: Alignment.center,
              child: Text(
                _completed ? "Done!" : "Checkout",
                style: TextStyle(
                  color: const Color.fromARGB(137, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  fontFamily: "Roboto_Condensed",
                ),
              ),
            ),
            Positioned(
              left: _dragPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragPosition += details.delta.dx;
                    if (_dragPosition < 0) _dragPosition = 0;
                    if (_dragPosition > width - 60.w)
                      _dragPosition = width - 60.w;
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (_dragPosition >= width - 60.w) {
                    setState(() {
                      _completed = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Success Checkout")),
                    );

                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _dragPosition = 0;
                        _completed = false;
                      });
                    });
                  } else {
                    setState(() {
                      _dragPosition = 0;
                    });
                  }
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.payments_outlined, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
