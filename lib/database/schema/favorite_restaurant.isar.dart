import 'package:isar/isar.dart';

part 'favorite_restaurant.isar.g.dart';

@collection
class FavoriteRestaurant {
  Id get isarId => fastHash(id);

  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
