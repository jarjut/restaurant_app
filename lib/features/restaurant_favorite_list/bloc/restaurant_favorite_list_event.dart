part of 'restaurant_favorite_list_bloc.dart';

abstract class RestaurantFavoriteListEvent extends Equatable {
  const RestaurantFavoriteListEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteRestaurants extends RestaurantFavoriteListEvent {}
