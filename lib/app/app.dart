import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurant_detail/pages/restaurant_page.dart';
import 'package:restaurant_app/features/restaurant_list/pages/restaurant_list_page.dart';
import 'package:restaurant_app/app/theme.dart';
import 'package:restaurant_app/features/restaurant_search/pages/restaurant_search_page.dart';
import 'package:restaurant_app/models/restaurant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: mainTheme,
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantSearchPage.routeName: (context) =>
            const RestaurantSearchPage(),
        RestaurantPage.routeName: (context) => RestaurantPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
