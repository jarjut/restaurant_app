import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/menu_item.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  static const routeName = '/restaurant';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
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
                          widget.restaurant.pictureId,
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
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.restaurant.description,
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
                    final food = widget.restaurant.menus.foods[index];
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
                  childCount: widget.restaurant.menus.foods.length,
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
                    final drink = widget.restaurant.menus.drinks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: RestaurantMenuItem(
                        name: drink.name,
                        description:
                            'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                        image: const AssetImage('assets/images/drink.jpg'),
                      ),
                    );
                  },
                  childCount: widget.restaurant.menus.drinks.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
