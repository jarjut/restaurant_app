import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:restaurant_app/constants/url.dart';
import 'package:restaurant_app/features/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/widgets/menu_item.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key, required this.id});

  final String id;

  static const routeName = '/restaurant';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantDetailCubit(
        id: id,
        restaurantRepository: getIt.get<RestaurantRepository>(),
      )..getRestaurantDetail(),
      child: const RestaurantBody(),
    );
  }
}

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  final scrollController = ScrollController();

  final appBarColorTween = ColorTween(
    begin: Colors.white,
    end: Colors.black,
  );

  final appBarStartTitleTween = Tween<double>(
    begin: 16,
    end: 72,
  );

  double lerp = 0.0;
  Color get appBarColor => appBarColorTween.transform(lerp) ?? Colors.white;
  double get appBarStartTitle => appBarStartTitleTween.transform(lerp);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    var offset = scrollController.offset;
    setState(() {
      lerp = offset < 184 ? offset / 184 : 1;
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
        builder: (context, state) {
          if (state is RestaurantDetailError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  TextButton(
                    onPressed: () => context
                        .read<RestaurantDetailCubit>()
                        .getRestaurantDetail(),
                    child: const Text('Retry'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }
          if (state is RestaurantDetailLoaded) {
            return ExtendedNestedScrollView(
              controller: scrollController,
              pinnedHeaderSliverHeightBuilder: () =>
                  kToolbarHeight + MediaQuery.of(context).padding.top - 4,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 240,
                    stretch: true,
                    floating: false,
                    pinned: true,
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    foregroundColor: appBarColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsetsDirectional.only(
                        start: appBarStartTitle,
                        bottom: 16,
                      ),
                      title: Text(
                        state.restaurant.name,
                        style: TextStyle(color: appBarColor),
                      ),
                      background: Hero(
                        tag: state.restaurant.pictureId,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                getMediumImage(state.restaurant.pictureId),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.restaurant.city,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Row(
                            children: [
                              RatingBar(
                                initialRating: state.restaurant.rating,
                                itemCount: 5,
                                allowHalfRating: true,
                                itemSize: 16,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half_rounded,
                                    color: Colors.amber,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline_rounded,
                                    color: Colors.amber,
                                  ),
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (value) {},
                              ),
                              const SizedBox(width: 2.0),
                              Text(
                                state.restaurant.rating.toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.restaurant.description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  SliverStickyHeader(
                    header: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Foods',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final food = state.restaurant.menus.foods[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: RestaurantMenuItem(
                              name: food.name,
                              description:
                                  'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                              image: const AssetImage('assets/images/food.jpg'),
                            ),
                          );
                        },
                        childCount: state.restaurant.menus.foods.length,
                      ),
                    ),
                  ),
                  SliverStickyHeader(
                    header: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final drink = state.restaurant.menus.drinks[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: RestaurantMenuItem(
                              name: drink.name,
                              description:
                                  'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                              image:
                                  const AssetImage('assets/images/drink.jpg'),
                            ),
                          );
                        },
                        childCount: state.restaurant.menus.drinks.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
