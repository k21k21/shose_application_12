import 'package:flutter/material.dart';

import '../../model/cart_item.dart';

import 'Quantity Button.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

final List<Color> cardColorssss = [
  // Original
  Color(0xffF2C6C6),

  Color(0xffBFDAD3),
  Color(0xffDDE9F8),

  //--------------------------------------//
];

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
                child: Image.asset(widget.item.image),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  widget.item.subtitle,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 70, 70, 70),
                  ),
                ),
                Text(
                  '\$${widget.item.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
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
