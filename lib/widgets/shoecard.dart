import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  final dynamic shoe; // ShoeItem من ViewModel
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ShoeCard({
    super.key,
    required this.shoe,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xffEFE6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                shoe.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shoe.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(shoe.subtitle,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${shoe.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onRemove,
                          child: _circleBtn(Icons.remove),
                        ),
                        const SizedBox(width: 6),
                        Text(quantity.toString(),
                            style:
                            const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: onAdd,
                          child: _circleBtn(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      height: 28,
      width: 28,
      decoration:
      const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Icon(icon, size: 16, color: Colors.white),
    );
  }
}
