import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/restaurant_detail/bloc/restaurant_favorited_bloc.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

class RestaurantFavoriteButton extends StatelessWidget {
  const RestaurantFavoriteButton({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantFavoritedBloc(
        restaurant: restaurant,
        restaurantRepository: getIt.get<RestaurantRepository>(),
      )..add(CheckIsRestaurantFavorited()),
      child: const RestaurantFavoriteButtonBody(),
    );
  }
}

class RestaurantFavoriteButtonBody extends StatelessWidget {
  const RestaurantFavoriteButtonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantFavoritedBloc, RestaurantFavoritedState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<RestaurantFavoritedBloc>().add(ToggleFavorite());
          },
          icon: state.isFavorited
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
        );
      },
    );
  }
}
