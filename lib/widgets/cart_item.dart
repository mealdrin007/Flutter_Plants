import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:plants/models/plant.dart';
import 'package:plants/provider/cart_provider.dart';
import 'package:plants/screens/cart_screen.dart';
import 'package:plants/widgets/quantity.dart';

class CartItem extends ConsumerStatefulWidget {
  final Plant plant;

  const CartItem({
    super.key,
    required this.plant,
  });

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.20,
          children: [
            SlidableAction(
              onPressed: (context) {
                ref.watch(cartProvider.notifier).removePlant(widget.plant);
                setState(() {
                  ref.watch(totalCostProvider.notifier).state -=
                      (widget.plant.price * widget.plant.quantity);
                });
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.close,
            ),
          ],
        ),
        child: SizedBox(
          height: 120,
          child: Card(
            color: Colors.white,
            elevation: 0,
            child: Center(
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 80,
                        maxWidth: 80,
                      ),
                      child: Image.asset(
                        widget.plant.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.plant.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            widget.plant.category.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: 'Poppins'),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            '\$ ${widget.plant.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                    Quantity(
                      plant: widget.plant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
