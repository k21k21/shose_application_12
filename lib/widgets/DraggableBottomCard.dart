import 'package:flutter/material.dart';
import 'package:shose_application_12/widgets/SwipeCheckoutButton.dart';
class DraggableBottomCard extends StatelessWidget {
  const DraggableBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.15,
      maxChildSize: 0.45,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            children: [
              // الخط الصغير أعلى البطاقه
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // محتوى البطاقة
              Expanded(
                child: ListView(
                  controller: controller,
                  children: const [
                    BottomPriceRow(title: 'Sub Total', price: 592),
                    BottomPriceRow(title: 'Delivery Fee', price: 3),
                    Divider(color: Colors.white24),
                    BottomPriceRow(title: 'Payable Amount', price: 595, bold: true),
                    SizedBox(height: 20),
                    SwipeCheckoutButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomPriceRow extends StatefulWidget {
  final String title;
  final int price;
  final bool bold;

  const BottomPriceRow({
    super.key,
    required this.title,
    required this.price,
    this.bold = false,
  });

  @override
  State<BottomPriceRow> createState() => _BottomPriceRowState();
}

class _BottomPriceRowState extends State<BottomPriceRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: const TextStyle(color: Colors.white70)),
          Text(
            '\$${widget.price}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
