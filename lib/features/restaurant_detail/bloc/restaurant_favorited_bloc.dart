import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_favorited_event.dart';
part 'restaurant_favorited_state.dart';

class RestaurantFavoritedBloc
    extends Bloc<RestaurantFavoritedEvent, RestaurantFavoritedState> {
  final Restaurant restaurant;
  final RestaurantRepository restaurantRepository;

  RestaurantFavoritedBloc({
    required this.restaurant,
    required this.restaurantRepository,
  }) : super(const RestaurantFavoritedState()) {
    on<CheckIsRestaurantFavorited>((event, emit) async {
      final isFavorited = await restaurantRepository.checkFavorite(restaurant);
      emit(RestaurantFavoritedState(isFavorited: isFavorited));
    });

    on<ToggleFavorite>(
      (event, emit) async {
        final isFavorited =
            await restaurantRepository.toggleFavorite(restaurant);
        emit(RestaurantFavoritedState(isFavorited: isFavorited));
      },
      transformer: droppable(),
    );
  }
}
