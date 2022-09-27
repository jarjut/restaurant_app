import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/url.dart';
import 'package:restaurant_app/database/isar.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/review.dart';

class RestaurantRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );

  final _isar = IsarDatabase.instance;
  final _favoriteCollection = IsarDatabase.instance.favoriteRestaurants;

  /// Get list of restaurants
  Future<List<Restaurant>> getRestaurantList() async {
    try {
      final response = await _client.get('/list');
      final list = response.data['restaurants'] as List;
      return list.map((e) => Restaurant.fromJson(e)).toList();
    } on DioError catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  /// Get detail of restaurant
  Future<Restaurant> getRestaurantDetail(String id) async {
    try {
      final response = await _client.get('/detail/$id');
      return Restaurant.fromJson(response.data['restaurant']);
    } on DioError catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  /// Search restaurant
  Future<List<Restaurant>> searchRestaurant(String query) async {
    try {
      final response = await _client.get('/search', queryParameters: {
        'q': query,
      });
      final list = response.data['restaurants'] as List;
      return list.map((e) => Restaurant.fromJson(e)).toList();
    } on DioError catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  // Add new review
  Future<List<Review>> addReview(String id, String name, String review) async {
    try {
      final response = await _client.post('/review', data: {
        'id': id,
        'name': name,
        'review': review,
      });
      final list = response.data['customerReviews'] as List;
      return list.map((e) => Review.fromJson(e)).toList();
    } on DioError catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> checkFavorite(Restaurant restaurant) async {
    try {
      final favorite = await _favoriteCollection
          .filter()
          .idEqualTo(restaurant.id)
          .findFirst();
      return favorite != null;
    } catch (e) {
      return false;
    }
  }

  /// Add restaurant to favorite if not exist, otherwise remove it
  Future<bool> toggleFavorite(Restaurant restaurant) async {
    try {
      final favorite = await _favoriteCollection
          .filter()
          .idEqualTo(restaurant.id)
          .findFirst();
      if (favorite == null) {
        final newFavorite = FavoriteRestaurant()
          ..id = restaurant.id
          ..name = restaurant.name
          ..description = restaurant.description
          ..pictureId = restaurant.pictureId
          ..city = restaurant.city
          ..rating = restaurant.rating;
        await _isar.writeTxn(() async {
          await _favoriteCollection.put(newFavorite);
        });
        return true;
      } else {
        await _isar.writeTxn(() async {
          _favoriteCollection.delete(favorite.isarId);
        });
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// Get list of favorite restaurants
  Future<List<Restaurant>> getFavoriteRestaurantList() async {
    final favorites = await _favoriteCollection.where().findAll();
    return favorites
        .map((e) => Restaurant(
              id: e.id,
              name: e.name,
              description: e.description,
              pictureId: e.pictureId,
              city: e.city,
              rating: e.rating,
            ))
        .toList();
  }

  /// Stream of favorite restaurants
  Stream<List<Restaurant>> getFavoriteRestaurantListStream() {
    return _favoriteCollection
        .where()
        .watch(fireImmediately: true)
        .map((event) => event
            .map((e) => Restaurant(
                  id: e.id,
                  name: e.name,
                  description: e.description,
                  pictureId: e.pictureId,
                  city: e.city,
                  rating: e.rating,
                ))
            .toList());
  }
}
