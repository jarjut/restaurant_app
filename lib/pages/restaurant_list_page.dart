import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final json = jsonDecode(snapshot.data!);
            final List listData = json['restaurants'];
            final listRestaurant =
                listData.map((e) => Restaurant.fromJson(e)).toList();
            return ListView.builder(
              itemCount: listRestaurant.length,
              itemBuilder: (context, index) {
                final restaurant = listRestaurant[index];
                return ListTile(
                  title: Text(restaurant.name),
                  trailing: Text(
                      '${restaurant.menus.drinks.length + restaurant.menus.foods.length} menus'),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: Text('List Restaurant'),
          );
        },
      ),
    );
  }
}
