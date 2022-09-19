import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/menu.dart';
import 'package:restaurant_app/models/review.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final List<Category> categories;
  final Menu menus;
  final List<Review> customerReviews;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.categories = const [],
    this.menus = const Menu(),
    this.customerReviews = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  @override
  String toString() => "Restaurant { id: $id, name: $name }";
}
