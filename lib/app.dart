import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantPage.routeName: (context) => RestaurantPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
