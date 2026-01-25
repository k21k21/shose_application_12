import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Moddel/cart_item.dart';

import '../viewmodel/cart_viewmodel.dart';

class QuantityButton extends StatefulWidget {
  final CartItem item;
  const QuantityButton({super.key, required this.item});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<CartViewModel>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: () {
              vm.decreaseQty(widget.item);
              setState(() {});
            },
          ),
          Text(widget.item.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add, size: 16, color: Colors.green),
            onPressed: () {
              vm.increaseQty(widget.item);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
