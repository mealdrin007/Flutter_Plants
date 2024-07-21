import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plants/models/plant.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Plant>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Plant>> {
  CartNotifier() : super([]);

  void addPlant(Plant plant) {
    final plantId = plant.id;
    final existingPlantIndex = state.indexWhere((item) => item.id == plantId);

    if (existingPlantIndex >= 0) {
      final existingPlant = state[existingPlantIndex];
      final updatedPlant = existingPlant.copyWith(
        quantity: existingPlant.quantity + 1,
      );
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingPlantIndex) updatedPlant else state[i]
      ];
    } else {
      final newItem = Plant(
        id: plant.id,
        name: plant.name,
        price: plant.price,
        description: plant.description,
        image: plant.image,
        category: plant.category,
        quantity: 1,
      );
      state = [...state, newItem];
    }
  }

  void removePlant(Plant plant) {
    final plantId = plant.id;
    state = state.where((item) => item.id != plantId).toList();
  }

  void decreaseQuantity(Plant plant) {
    final plantId = plant.id;
    final existingPlantIndex = state.indexWhere((item) => item.id == plantId);

    if (existingPlantIndex >= 0) {
      final existingPlant = state[existingPlantIndex];
      if (existingPlant.quantity > 1) {
        final updatedPlant = existingPlant.copyWith(
          quantity: existingPlant.quantity - 1,
        );
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == existingPlantIndex) updatedPlant else state[i]
        ];
      } else {
        removePlant(plant);
      }
    }
  }

  void removeAll() {
    state = [];
  }
}
