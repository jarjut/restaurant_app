part of 'restaurant_search_bloc.dart';

abstract class RestaurantSearchEvent extends Equatable {
  const RestaurantSearchEvent();

  @override
  List<Object> get props => [];
}

class RestaurantSearchQueryChanged extends RestaurantSearchEvent {
  final String query;

  const RestaurantSearchQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}
