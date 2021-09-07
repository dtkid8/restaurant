import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/data/core/api_constants.dart';
import 'package:restaurant/data/model/restaurant.dart';

import 'fetch_restaurant.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final url = ApiConstants.BASE_URL+ApiConstants.GET_LIST;
  group('Get List Restaurant', () {
    test('return restaurant result parsed from API', () async {
      final client = MockClient();
      when(client
              .get(Uri.parse(url)))
          .thenAnswer((_) async =>
              http.Response('{"error": false, "message": "success", "count": 20, "restaurants" :[]}', 200));

      expect(await ApiClient(client: client).getListRestaurant(), isA<Restaurant>());
    });
  });
}