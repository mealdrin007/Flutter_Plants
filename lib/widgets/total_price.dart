// total_price.dart
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final double totalPrice;

  const TotalPrice({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$ ',
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          '${totalPrice.toStringAsFixed(2)} ',
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
