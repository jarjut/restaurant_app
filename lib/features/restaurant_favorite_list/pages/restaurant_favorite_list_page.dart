import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/features/restaurant_favorite_list/bloc/restaurant_favorite_list_bloc.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantFavoriteListPage extends StatelessWidget {
  const RestaurantFavoriteListPage({super.key});

  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantFavoriteListBloc(
        restaurantRepository: getIt.get<RestaurantRepository>(),
      )..add(LoadFavoriteRestaurants()),
      child: const RestaurantFavoriteListBody(),
    );
  }
}

class RestaurantFavoriteListBody extends StatelessWidget {
  const RestaurantFavoriteListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body:
          BlocBuilder<RestaurantFavoriteListBloc, RestaurantFavoriteListState>(
        builder: (context, state) {
          if (state is RestaurantFavoriteListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RestaurantFavoriteListError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 54,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(height: 8),
                  Text(state.message),
                  TextButton(
                    onPressed: () => context
                        .read<RestaurantFavoriteListBloc>()
                        .add(LoadFavoriteRestaurants()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is RestaurantFavoriteListLoaded) {
            final listRestaurant = state.restaurants;

            // Empty State
            if (listRestaurant.isEmpty) {
              return const Center(
                child: Text('No Favorite Restaurant'),
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: listRestaurant.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: RestaurantItem(restaurant: listRestaurant[index]),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
