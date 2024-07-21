import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plants/models/plant.dart';
import 'package:plants/utils/string_extension.dart';
import 'package:plants/widgets/plant_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, List<Plant>>> futurePlants;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    futurePlants = fetchPlants();
    futurePlants.then((plants) {
      categories = plants.keys.toList();
      _tabController = TabController(length: categories.length, vsync: this);
      _tabController.addListener(() {
        setState(() {});
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, List<Plant>>> fetchPlants() async {
    final String response =
        await rootBundle.loadString('assets/data/plants.json');
    final Map<String, dynamic> jsonResponse = json.decode(response);
    Map<String, List<Plant>> plants = {};
    jsonResponse.forEach((key, value) {
      plants[key] =
          (value as List).map((plant) => Plant.fromJson(plant, key)).toList();
    });
    return plants;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/menu.png'),
          onPressed: () {
            if (kDebugMode) {
              print('menu tapped');
            }
          },
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search.png'),
            onPressed: () {
              if (kDebugMode) {
                print('search tapped');
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'Plants',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          if (categories.isNotEmpty)
            SizedBox(
              height: screenHeight * 0.06,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = _tabController.index == index;
                    return GestureDetector(
                      onTap: () {
                        _tabController.animateTo(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(
                              category.capitalize(),
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (isSelected)
                              Container(
                                width: screenWidth * 0.02,
                                height: screenHeight * 0.02,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
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
          Expanded(
            child: FutureBuilder<Map<String, List<Plant>>>(
              future: futurePlants,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return TabBarView(
                    controller: _tabController,
                    children: categories
                        .map((category) => PlantList(
                              plants: snapshot.data![category]!,
                            ))
                        .toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
