part of 'restaurant_detail_cubit.dart';

abstract class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object> get props => [];
}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailError extends RestaurantDetailState {
  final String message;

  const RestaurantDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class RestaurantDetailLoaded extends RestaurantDetailState {
  final Restaurant restaurant;

  const RestaurantDetailLoaded(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
