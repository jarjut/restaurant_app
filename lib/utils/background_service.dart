import 'dart:ui';
import 'dart:isolate';
import 'dart:math';

import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    final restaurants = await RestaurantRepository().getRestaurantList();
    // Get random restaurant
    final random = Random();
    final restaurant = restaurants[random.nextInt(restaurants.length)];
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      restaurant,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
