part of 'restaurant_favorite_list_bloc.dart';

abstract class RestaurantFavoriteListEvent extends Equatable {
  const RestaurantFavoriteListEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteRestaurants extends RestaurantFavoriteListEvent {}

class UpdateFavoriteRestaurants extends RestaurantFavoriteListEvent {
  final List<Restaurant> restaurants;

  const UpdateFavoriteRestaurants(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}
