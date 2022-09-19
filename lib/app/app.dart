import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurant_detail/pages/restaurant_page.dart';
import 'package:restaurant_app/features/restaurant_list/pages/restaurant_list_page.dart';
import 'package:restaurant_app/app/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: mainTheme,
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantPage.routeName: (context) => RestaurantPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
