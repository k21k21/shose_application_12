import 'package:flutter/material.dart';

class SummaryRow extends StatefulWidget {
  final String title;
  final String value;

  const SummaryRow(this.title, this.value, {super.key});

  @override
  State<SummaryRow> createState() => _SummaryRowState();
}

class _SummaryRowState extends State<SummaryRow> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: width * 0.038,
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
