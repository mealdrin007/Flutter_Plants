import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plants/models/plant.dart';
import 'package:plants/provider/cart_provider.dart';
import 'package:plants/screens/cart_screen.dart';
import 'package:plants/screens/plant_screen.dart';
import 'package:plants/utils/string_extension.dart';

class PlantList extends ConsumerStatefulWidget {
  final List<Plant> plants;

  const PlantList({super.key, required this.plants});

  @override
  ConsumerState<PlantList> createState() => _PlantListState();
}

class _PlantListState extends ConsumerState<PlantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                int index = (scrollNotification.metrics.pixels /
                        (screenWidth * 0.60 + 16))
                    .round();
                setState(() {
                  _selectedIndex = index;
                });
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.plants.length,
              itemBuilder: (context, index) {
                final plant = widget.plants[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantScreen(plant: plant),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.60,
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: screenHeight * 0.15,
                                  decoration: BoxDecoration(
                                    color: _selectedIndex == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).colorScheme.shadow,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          plant.category.capitalize(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .canvasColor
                                                .withOpacity(0.7),
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          plant.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).canvasColor,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: '\$ ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Theme.of(context).canvasColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: plant.price
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                bottom: screenHeight * 0.06,
                                left: screenWidth * 0.25,
                                child: FractionallySizedBox(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(plant.image),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: screenHeight * 0.2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          IconButton(
                            icon: SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset('assets/icons/plus.png'),
                            ),
                            onPressed: () {
                              if (kDebugMode) {
                                print('add tapped');
                              }
                            },
                          ),
                        ],
                      ),
                      Text(
                        widget.plants[_selectedIndex].description,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        iconSize: 30,
                        icon: ImageIcon(
                          const AssetImage('assets/icons/bag.png'),
                          color: Theme.of(context).canvasColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: 0,
                      child: Container(
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${cartItems.length}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
