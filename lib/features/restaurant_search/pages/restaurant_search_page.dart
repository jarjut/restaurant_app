import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/features/restaurant_search/bloc/restaurant_search_bloc.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantSearchPage extends StatelessWidget {
  const RestaurantSearchPage({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantSearchBloc(
        restaurantRepository: getIt.get<RestaurantRepository>(),
      ),
      child: const RestaurantSearchBody(),
    );
  }
}

class RestaurantSearchBody extends StatefulWidget {
  const RestaurantSearchBody({super.key});

  @override
  State<RestaurantSearchBody> createState() => _RestaurantSearchBodyState();
}

class _RestaurantSearchBodyState extends State<RestaurantSearchBody> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Restaurant',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: TextField(
              autofocus: true,
              controller: _searchController,
              onChanged: (value) => context
                  .read<RestaurantSearchBloc>()
                  .add(RestaurantSearchQueryChanged(query: value)),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: const Icon(Icons.search, size: 24),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RestaurantSearchBloc, RestaurantSearchState>(
              builder: (context, state) {
                if (state is RestaurantSearchInitial) {
                  return const Center(
                    child: Text(
                      'Search for a restaurant',
                    ),
                  );
                }

                if (state is RestaurantSearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is RestaurantSearchError) {
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
                              .read<RestaurantSearchBloc>()
                              .add(RestaurantSearchQueryChanged(
                                  query: _searchController.text)),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is RestaurantSearchLoaded) {
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
                        child:
                            RestaurantItem(restaurant: listRestaurant[index]),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
