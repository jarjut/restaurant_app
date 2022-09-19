part of 'restaurant_list_bloc.dart';

abstract class RestaurantListEvent extends Equatable {
  const RestaurantListEvent();

  @override
  List<Object> get props => [];
}

class GetRestaurantList extends RestaurantListEvent {}

class SearchRestaurantList extends RestaurantListEvent {
  final String query;

  const SearchRestaurantList(this.query);

  @override
  List<Object> get props => [query];
}
