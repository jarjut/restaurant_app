import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantPage.routeName,
            arguments: restaurant);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCard(
            height: 200,
            width: double.infinity,
            image: NetworkImage(restaurant.pictureId),
            heroTag: restaurant.pictureId,
            child: Row(
              children: [
                Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Ink(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset('assets/images/chef.png'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Row(
                      children: [
                        RatingBar(
                          initialRating: restaurant.rating,
                          itemCount: 5,
                          allowHalfRating: true,
                          itemSize: 16,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: Colors.white,
                            ),
                            empty: const Icon(
                              Icons.star_outline_rounded,
                              color: Colors.white,
                            ),
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (value) {},
                        ),
                        const SizedBox(width: 2.0),
                        Text(
                          restaurant.rating.toString(),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.bowlFood,
                    size: 12,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    '${restaurant.menus.foods.length} foods',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.martiniGlass,
                    size: 12,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    '${restaurant.menus.drinks.length} drinks',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6.0),
          Text(
            restaurant.description,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    this.child,
    Object? heroTag,
  })  : heroTag = heroTag ?? image,
        super(key: key);

  final ImageProvider image;
  final double height;
  final double width;
  final Object heroTag;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Hero(
      tag: heroTag,
      child: Material(
        borderRadius: borderRadius,
        elevation: 10,
        child: Ink(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
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
              ),
              if (child != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: child!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
