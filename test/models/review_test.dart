import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/review.dart';

void main() {
  test('parse json to review model', () {
    final reviewJson = {
      "name": "Ahmad",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    };

    final review = Review.fromJson(reviewJson);

    expect(review.name, "Ahmad");
    expect(review.review, "Tidak rekomendasi untuk pelajar!");
    expect(review.date, "13 November 2019");
  });
}
