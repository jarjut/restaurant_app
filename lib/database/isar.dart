import 'package:isar/isar.dart';
import 'package:restaurant_app/database/schema/favorite_restaurant.isar.dart';

export './schema/schema.dart';
export 'package:isar/isar.dart';

/// Isar Singleton
class IsarDatabase {
  static late Isar _isar;

  factory IsarDatabase() => IsarDatabase._internal();

  IsarDatabase._internal();

  /// Open Isar database
  Future<void> init() async {
    _isar = await Isar.open([FavoriteRestaurantSchema]);
  }

  /// Get Isar instance
  static Isar get instance => _isar;
}
