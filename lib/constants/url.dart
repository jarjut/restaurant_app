const baseUrl = 'https://restaurant-api.dicoding.dev';

String getSmallImage(String pictureId) => '$baseUrl/images/small/$pictureId';
String getMediumImage(String pictureId) => '$baseUrl/images/medium/$pictureId';
String getLargeImage(String pictureId) => '$baseUrl/images/large/$pictureId';
