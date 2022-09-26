part of 'restaurant_favorited_bloc.dart';

class RestaurantFavoritedState extends Equatable {
  const RestaurantFavoritedState({
    this.isFavorited = false,
  });

  final bool isFavorited;

  @override
  List<Object> get props => [isFavorited];
}
