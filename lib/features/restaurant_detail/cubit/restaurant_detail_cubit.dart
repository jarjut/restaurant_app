import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

  void addReview({required String name, required String review}) async {
    if (state is RestaurantDetailLoaded) {
      try {
        final reviews = await restaurantRepository.addReview(
          id,
          name,
          review,
        );
        final restaurant =
            (state as RestaurantDetailLoaded).restaurant.copyWith(
                  customerReviews: reviews,
                );
        emit(RestaurantDetailLoaded(restaurant));
      } catch (e) {
        debugPrint('Failed to add review');
      }
    }
  }
}
