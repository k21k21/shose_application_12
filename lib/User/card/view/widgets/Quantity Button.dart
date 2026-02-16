import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/cart_item.dart';

import '../../viewmodel/cart_viewmodel.dart';

class QuantityButton extends StatefulWidget {
  final CartItem item;
  const QuantityButton({super.key, required this.item});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                widget.item.quantity == 1 ? Icons.delete_outline : Icons.remove,
                size: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                final vm = context.read<CartViewModel>();
                if (widget.item.quantity == 1) {
                  vm.removeItem(widget.item);
                } else {
                  vm.decreaseQty(widget.item);
                }
                setState(() {});
              },
            ),
          ),
        ),
        Text(
          widget.item.quantity.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto_Condensed",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 16,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                final vm = context.read<CartViewModel>();
                vm.increaseQty(widget.item);
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
