part of 'restaurant_favorited_bloc.dart';

abstract class RestaurantFavoritedEvent extends Equatable {
  const RestaurantFavoritedEvent();

  @override
  List<Object> get props => [];
}

class CheckIsRestaurantFavorited extends RestaurantFavoritedEvent {}

class ToggleFavorite extends RestaurantFavoritedEvent {}
