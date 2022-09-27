import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/restaurant.dart';

void main() {
  test('parse json to restaurant model', () {
    final restaurantJson = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    final restaurant = Restaurant.fromJson(restaurantJson);

    expect(restaurant.id, "rqdv5juczeskfw1e867");
    expect(restaurant.name, "Melting Pot");
    expect(restaurant.pictureId, "14");
    expect(restaurant.city, "Medan");
    expect(restaurant.rating, 4.2);
  });
}
