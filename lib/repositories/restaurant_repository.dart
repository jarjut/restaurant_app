import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/url.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/review.dart';

class RestaurantRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );

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
}
