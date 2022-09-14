import 'package:restaurant_app/models/drink.dart';
import 'package:restaurant_app/models/food.dart';

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({
    this.foods = const [],
    this.drinks = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: (json['foods'] as List).map((e) => Food.fromJson(e)).toList(),
      drinks: (json['drinks'] as List).map((e) => Drink.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foods': foods.map((e) => e.toJson()).toList(),
      'drinks': drinks.map((e) => e.toJson()).toList(),
    };
  }
}
