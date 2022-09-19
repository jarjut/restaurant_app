import 'package:get_it/get_it.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<RestaurantRepository>(RestaurantRepository());
}
