import 'package:flutter/material.dart';

class PlantSpecCard extends StatelessWidget {
  final Icon icon;
  final String element;
  final String value;
  const PlantSpecCard({
    super.key,
    required this.icon,
    required this.element,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Theme.of(context).primaryColorDark,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundColor: Theme.of(context).canvasColor,
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Text(
              element,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).canvasColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
