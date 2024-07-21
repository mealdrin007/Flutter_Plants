import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plants/models/plant.dart';
import 'package:plants/provider/cart_provider.dart';
import 'package:plants/screens/cart_screen.dart';

class Quantity extends ConsumerStatefulWidget {
  final Plant plant;
  const Quantity({
    super.key,
    required this.plant,
  });

  @override
  ConsumerState<Quantity> createState() => _QuantityState();
}

class _QuantityState extends ConsumerState<Quantity> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 244, 245, 245)),
          borderRadius: BorderRadius.circular(50)),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: IconButton(
              onPressed: () {
                ref.watch(cartProvider.notifier).addPlant(widget.plant);
                setState(() {
                  ref.watch(totalCostProvider.notifier).state +=
                      widget.plant.price;
                });
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xffb2b5b6),
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '${widget.plant.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 30,
            child: IconButton(
              onPressed: () {
                ref.watch(cartProvider.notifier).decreaseQuantity(widget.plant);
                setState(() {
                  ref.watch(totalCostProvider.notifier).state -=
                      widget.plant.price;
                });
              },
              icon: const Icon(
                Icons.remove,
                color: Color(0xffb2b5b6),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
