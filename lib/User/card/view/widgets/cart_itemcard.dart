import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_item.dart';
import 'Quantity Button.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.04),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Color(0xffBEE7E8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.18,
            height: width * 0.18,
            decoration: BoxDecoration(
              color: const Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Transform.rotate(
              angle: -0.6,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 10),

                child: Image.memory(
                  base64Decode(
                    widget.item.img.contains(',')
                        ? widget.item.img.split(',').last
                        : widget.item.img,
                  ),
                  width: 160.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.item.brand,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 70, 70, 70),
                  ),
                ),
                Text(
                  '${widget.item.price} EGP',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 8),
              QuantityButton(item: widget.item),
            ],
          ),
        ],
      ),
    );
  }
}
