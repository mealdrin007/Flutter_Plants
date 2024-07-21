import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plants/models/plant.dart';
import 'package:plants/provider/cart_provider.dart';
import 'package:plants/screens/cart_screen.dart';
import 'package:plants/widgets/plant_spec_widget.dart';

class PlantScreen extends ConsumerStatefulWidget {
  final Plant plant;

  const PlantScreen({
    super.key,
    required this.plant,
  });

  @override
  ConsumerState<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends ConsumerState<PlantScreen> {
  void addPlant() {
    ref.read(cartProvider.notifier).addPlant(widget.plant);
    setState(() {
      ref.read(totalCostProvider.notifier).state += widget.plant.price;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Plant Added to Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/menu.png'),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Menu Clicked'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Image.asset(
                  'assets/icons/bag.png',
                  height: 30,
                ),
                cartItems.isEmpty
                    ? Container()
                    : Container(
                        alignment: Alignment.topCenter,
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: TextStyle(
                            fontSize: 9,
                            color: Theme.of(context).canvasColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70))),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.plant.name,
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(
                        widget.plant.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '\$',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: widget.plant.price
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 70,
                                        child: FittedBox(
                                          child: FloatingActionButton(
                                            heroTag: 'btn1',
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            backgroundColor:
                                                Theme.of(context).canvasColor,
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                      'Plant Book Marked'),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                ),
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/icons/bookmark.png',
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 70,
                                        child: FittedBox(
                                          child: FloatingActionButton(
                                            heroTag: 'btn2',
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            onPressed: addPlant,
                                            child: Image.asset(
                                              'assets/icons/addbag.png',
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.plant.image)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.55,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.337,
                      child: const PlantSpecWidget()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
