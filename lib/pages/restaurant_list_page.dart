import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Restaurant List'),
      // ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // show restaurant list
            if (snapshot.hasData) {
              final json = jsonDecode(snapshot.data!);
              final List listData = json['restaurants'];
              final listRestaurant =
                  listData.map((e) => Restaurant.fromJson(e)).toList();
              return ListView.separated(
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
            // show error
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
