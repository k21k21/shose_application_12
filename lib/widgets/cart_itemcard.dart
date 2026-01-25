import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Moddel/cart_item.dart';

import '../viewmodel/cart_viewmodel.dart';
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
    final vm = context.read<CartViewModel>();
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.04),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Image.asset(widget.item.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(widget.item.subtitle,
                    style: const TextStyle(color: Colors.grey)),
                Text('\$${widget.item.price}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  vm.removeItem(widget.item);
                  setState(() {});
                },
                child:  Icon(Icons.delete, size: 18,color: Colors.red,),
              ),
               SizedBox(height: 8),
              QuantityButton(item: widget.item),
            ],
          )
        ],
      ),
    );
  }
}
