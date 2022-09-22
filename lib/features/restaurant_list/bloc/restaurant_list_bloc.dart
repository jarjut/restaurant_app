import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  final RestaurantRepository restaurantRepository;
  RestaurantListBloc({
    required this.restaurantRepository,
  }) : super(RestaurantListLoading()) {
    on<GetRestaurantList>((event, emit) async {
      try {
        final restaurants = await restaurantRepository.getRestaurantList();
        emit(RestaurantListLoaded(restaurants));
      } catch (e) {
        emit(const RestaurantListError('Failed to load restaurant list'));
      }
    });
  }
}
