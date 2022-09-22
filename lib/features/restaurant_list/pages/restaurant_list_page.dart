import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/features/restaurant_list/bloc/restaurant_list_bloc.dart';
import 'package:restaurant_app/features/restaurant_search/pages/restaurant_search_page.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantListBloc(
        restaurantRepository: getIt.get<RestaurantRepository>(),
      )..add(GetRestaurantList()),
      child: const RestaurantListBody(),
    );
  }
}

class RestaurantListBody extends StatelessWidget {
  const RestaurantListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120,
              stretch: true,
              floating: false,
              pinned: true,
              foregroundColor: Colors.black,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(
                  start: 16,
                  bottom: 16,
                ),
                background: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.75],
                      colors: [
                        Colors.green.shade100,
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
                title: const Text(
                  'Restaurant App',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RestaurantSearchPage.routeName);
                  },
                ),
              ],
            ),
          ];
        },
        body: BlocBuilder<RestaurantListBloc, RestaurantListState>(
          builder: (context, state) {
            if (state is RestaurantListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is RestaurantListError) {
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
                          .read<RestaurantListBloc>()
                          .add(GetRestaurantList()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is RestaurantListLoaded) {
              final listRestaurant = state.restaurants;

              // Empty State
              if (listRestaurant.isEmpty) {
                return const Center(
                  child: Text('No Restaurant'),
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
      ),
    );
  }
}
