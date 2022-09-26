import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_favorite_list_event.dart';
part 'restaurant_favorite_list_state.dart';

class RestaurantFavoriteListBloc
    extends Bloc<RestaurantFavoriteListEvent, RestaurantFavoriteListState> {
  final RestaurantRepository restaurantRepository;
  RestaurantFavoriteListBloc({required this.restaurantRepository})
      : super(RestaurantFavoriteListLoading()) {
    on<GetFavoriteRestaurants>((event, emit) async {
      try {
        final restaurants =
            await restaurantRepository.getFavoriteRestaurantList();
        emit(RestaurantFavoriteListLoaded(restaurants));
      } catch (e) {
        emit(
          const RestaurantFavoriteListError(
              'Failed to load favorite restaurant list'),
        );
      }
    });
  }
}
