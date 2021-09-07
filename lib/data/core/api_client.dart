import 'dart:convert';
import 'package:restaurant/data/core/api_constants.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurant/data/model/restaurant_detail.dart';

class ApiClient {
  final Client client;
  ApiClient({required this.client});
  Future<Restaurant> getListRestaurant() async {
    final url = ApiConstants.BASE_URL+ApiConstants.GET_LIST;
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = Restaurant.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final url = ApiConstants.BASE_URL+ApiConstants.GET_DETAIL+id;
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      final result = RestaurantDetail.fromJson(json.decode(response.body));
      return result;
    }
    else{
      throw Exception('Failed to load Detail');
    }
  }


  Future<Restaurant> getSearchRestaurant(String query) async {
    final url = ApiConstants.BASE_URL+ApiConstants.SEARCH+query;
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      final result = Restaurant.fromJson(json.decode(response.body));
      return result;
    }
    else{
      throw Exception('Failed to load Detail');
    }
  }
} 