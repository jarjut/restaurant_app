part of 'restaurant_favorite_list_bloc.dart';

abstract class RestaurantFavoriteListState extends Equatable {
  const RestaurantFavoriteListState();

  @override
  List<Object> get props => [];
}

class RestaurantFavoriteListLoading extends RestaurantFavoriteListState {}

class RestaurantFavoriteListLoaded extends RestaurantFavoriteListState {
  const RestaurantFavoriteListLoaded(this.restaurants);

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantFavoriteListError extends RestaurantFavoriteListState {
  const RestaurantFavoriteListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
