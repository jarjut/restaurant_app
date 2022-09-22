part of 'restaurant_search_bloc.dart';

abstract class RestaurantSearchState extends Equatable {
  const RestaurantSearchState();

  @override
  List<Object> get props => [];
}

class RestaurantSearchInitial extends RestaurantSearchState {}

class RestaurantSearchLoading extends RestaurantSearchState {}

class RestaurantSearchError extends RestaurantSearchState {
  final String message;

  const RestaurantSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class RestaurantSearchLoaded extends RestaurantSearchState {
  final List<Restaurant> restaurants;

  bool get isEmpty => restaurants.isEmpty;

  const RestaurantSearchLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}
