import 'package:flutter/material.dart';
import 'package:restaurant/data/database/database_helper.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/provider/state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  List<Restaurants> _restaurants = [];
  final DatabaseHelper databaseHelper;

  late ProviderState _state;
  ProviderState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> get restaurants => _restaurants;
  RestaurantFavoriteProvider({required this.databaseHelper}) {
    getAllRestaurants();
  }

  void getAllRestaurants() async {
    _state = ProviderState.NoData;
    _restaurants = await databaseHelper.getRestaurants();
    if (_restaurants.length > 0) {
      _state = ProviderState.HasData;
    } else {
      _state = ProviderState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurants restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      getAllRestaurants();
    } catch (e) {
      _state = ProviderState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final restaurant = await databaseHelper.getFavorite(id);
    return restaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      getAllRestaurants();
    } catch (e) {
      _state = ProviderState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
