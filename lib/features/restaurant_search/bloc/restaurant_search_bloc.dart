import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_search_event.dart';
part 'restaurant_search_state.dart';

class RestaurantSearchBloc
    extends Bloc<RestaurantSearchEvent, RestaurantSearchState> {
  final RestaurantRepository restaurantRepository;
  RestaurantSearchBloc({required this.restaurantRepository})
      : super(RestaurantSearchInitial()) {
    on<RestaurantSearchQueryChanged>(
      (event, emit) async {
        if (event.query.isEmpty) {
          emit(RestaurantSearchInitial());
        } else {
          try {
            emit(RestaurantSearchLoading());
            final restaurants = await restaurantRepository.searchRestaurant(
              event.query,
            );
            emit(RestaurantSearchLoaded(restaurants));
          } catch (e) {
            emit(const RestaurantSearchError(
                'Failed to search restaurant list'));
          }
        }
      },
      transformer: droppable(),
    );
  }
}
