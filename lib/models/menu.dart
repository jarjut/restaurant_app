import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/models/drink.dart';
import 'package:restaurant_app/models/food.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  const Menu({
    this.foods = const [],
    this.drinks = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
