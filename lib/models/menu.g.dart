// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      foods: (json['foods'] as List<dynamic>?)
              ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      drinks: (json['drinks'] as List<dynamic>?)
              ?.map((e) => Drink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };
