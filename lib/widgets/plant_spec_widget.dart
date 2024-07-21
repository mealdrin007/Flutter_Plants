import 'package:flutter/material.dart';
import 'package:plants/widgets/plant_spec_card.dart';

class PlantSpecWidget extends StatelessWidget {
  const PlantSpecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const PlantSpecCard(
                            element: 'Light',
                            value: 'Sunlight',
                            icon: Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                              size: 30,
                            )),
                        PlantSpecCard(
                          element: 'Water',
                          value: 'Low Water',
                          icon: Icon(
                            Icons.water_drop_outlined,
                            color: Colors.blueAccent.shade100,
                            size: 30,
                          ),
                        ),
                        PlantSpecCard(
                          element: 'Temper',
                          value: '28°C',
                          icon: Icon(
                            Icons.thermostat,
                            color: Colors.purple[200],
                            size: 30,
                          ),
                        ),
                      ],
                    );
  }
}