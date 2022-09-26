import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_favorite_list_event.dart';
part 'restaurant_favorite_list_state.dart';

class RestaurantFavoriteListBloc
    extends Bloc<RestaurantFavoriteListEvent, RestaurantFavoriteListState> {
  final RestaurantRepository restaurantRepository;
  StreamSubscription? _restaurantListSubscription;

  RestaurantFavoriteListBloc({required this.restaurantRepository})
      : super(RestaurantFavoriteListLoading()) {
    on<LoadFavoriteRestaurants>((event, emit) async {
      _restaurantListSubscription?.cancel();
      _restaurantListSubscription =
          restaurantRepository.getFavoriteRestaurantListStream().listen(
                (restaurants) => add(UpdateFavoriteRestaurants(restaurants)),
              );
    });

    on<UpdateFavoriteRestaurants>((event, emit) {
      emit(RestaurantFavoriteListLoaded(event.restaurants));
    });
  }

  @override
  Future<void> close() {
    _restaurantListSubscription?.cancel();
    return super.close();
  }
}
