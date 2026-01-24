import 'package:flutter/material.dart';

class SwipeCheckoutButton extends StatefulWidget {
  final VoidCallback? onCheckout;

  const SwipeCheckoutButton({super.key, this.onCheckout});

  @override
  State<SwipeCheckoutButton> createState() => _SwipeCheckoutButtonState();
}

class _SwipeCheckoutButtonState extends State<SwipeCheckoutButton> {
  double dragX = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Swipe to Checkout  >>>',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: dragX,
            child: GestureDetector(
              onHorizontalDragUpdate: (d) {
                setState(() {
                  dragX += d.delta.dx;
                  if (dragX < 0) dragX = 0;
                  if (dragX > 220) dragX = 220;
                });
              },
              onHorizontalDragEnd: (_) {
                if (dragX >= 220) {
                  if (widget.onCheckout != null) widget.onCheckout!();
                  debugPrint('Checkout Done');
                }
                setState(() => dragX = 0);
              },
              child: Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xff2C134E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
