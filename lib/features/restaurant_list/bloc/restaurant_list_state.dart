part of 'restaurant_list_bloc.dart';

abstract class RestaurantListState extends Equatable {
  const RestaurantListState();

  @override
  List<Object> get props => [];
}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final List<Restaurant> restaurants;

  bool get isEmpty => restaurants.isEmpty;

  const RestaurantListLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];

  @override
  String toString() => 'Restaurant List Loaded';
}

class RestaurantListError extends RestaurantListState {
  final String message;

  const RestaurantListError(this.message);

  @override
  List<Object> get props => [message];
}
