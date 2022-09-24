import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/constants/url.dart';
import 'package:restaurant_app/features/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:restaurant_app/features/restaurant_review/pages/restaurant_review_page.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/review.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/widgets/menu_item.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  static const routeName = '/restaurant';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantDetailCubit(
        id: restaurant.id,
        restaurantRepository: getIt.get<RestaurantRepository>(),
      )..getRestaurantDetail(),
      child: RestaurantBody(restaurant: restaurant),
    );
  }
}

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key, required this.restaurant});

  final Restaurant restaurant;

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
    final detailCubit = BlocProvider.of<RestaurantDetailCubit>(context);
    return Scaffold(
      body: ExtendedNestedScrollView(
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
                  widget.restaurant.name,
                  style: TextStyle(color: appBarColor),
                ),
                background: Hero(
                  tag: widget.restaurant.pictureId,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          getMediumImage(widget.restaurant.pictureId),
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
                      widget.restaurant.city,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
                      builder: (_, state) {
                        List<Review>? reviews;
                        if (state is RestaurantDetailLoaded) {
                          reviews = state.restaurant.customerReviews;
                        }

                        return InkWell(
                          onTap: reviews != null
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider.value(
                                          value: detailCubit,
                                          child: const RestaurantReviewPage(),
                                        );
                                      },
                                    ),
                                  );
                                }
                              : null,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RatingBar(
                                    initialRating: widget.restaurant.rating,
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
                                    widget.restaurant.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )
                                ],
                              ),
                              if (reviews != null)
                                Text(
                                  reviews.isEmpty
                                      ? 'No reviews'
                                      : 'See ${reviews.length} reviews',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.blue.shade700,
                                      ),
                                )
                              else
                                Text('',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.restaurant.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
                      builder: (context, state) {
                        if (state is RestaurantDetailLoaded) {
                          final categories = state.restaurant.categories;
                          if (categories.isNotEmpty) {
                            return Text(
                                'Categories: ${categories.map((e) => e.name).reduce((value, element) => '$value, $element')}');
                          }
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
              builder: (context, state) {
                if (state is RestaurantDetailLoading) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is RestaurantDetailError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.triangleExclamation,
                              size: 54,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            const SizedBox(height: 8),
                            Text(state.message),
                            TextButton(
                              onPressed: () => context
                                  .read<RestaurantDetailCubit>()
                                  .getRestaurantDetail(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is RestaurantDetailLoaded) {
                  return MultiSliver(
                    children: [
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
                                  image: const AssetImage(
                                      'assets/images/food.jpg'),
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
                              final drink =
                                  state.restaurant.menus.drinks[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: RestaurantMenuItem(
                                  name: drink.name,
                                  description:
                                      'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                                  image: const AssetImage(
                                      'assets/images/drink.jpg'),
                                ),
                              );
                            },
                            childCount: state.restaurant.menus.drinks.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
