import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final String id;
  final RestaurantRepository restaurantRepository;

  RestaurantDetailCubit({
    required this.id,
    required this.restaurantRepository,
  }) : super(RestaurantDetailLoading());

  void getRestaurantDetail() async {
    try {
      emit(RestaurantDetailLoading());
      final restaurant = await restaurantRepository.getRestaurantDetail(id);
      emit(RestaurantDetailLoaded(restaurant));
    } catch (e) {
      emit(const RestaurantDetailError('Failed to load restaurant detail'));
    }
  }
}
