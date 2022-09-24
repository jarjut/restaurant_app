// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/menu.dart';
import 'package:restaurant_app/models/review.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
        categories,
        menus,
        customerReviews
      ];

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
    List<Category>? categories,
    Menu? menus,
    List<Review>? customerReviews,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      categories: categories ?? this.categories,
      menus: menus ?? this.menus,
      customerReviews: customerReviews ?? this.customerReviews,
    );
  }
}
