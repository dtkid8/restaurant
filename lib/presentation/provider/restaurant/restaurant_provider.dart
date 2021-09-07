import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/provider/state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiClient apiClient;
  RestaurantProvider({
    required this.apiClient,
  }) {
    _fetchAllRestaurant();
  }

  late Restaurant _restaurant;
  String _message = "";
  late ProviderState _state;

  String get message => _message;

  Restaurant get result => _restaurant;

  ProviderState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ProviderState.Loading;
      notifyListeners();
      final restaurant = await apiClient.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ProviderState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ProviderState.HasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } on SocketException {
      _state = ProviderState.Error;
      notifyListeners();
      return _message = 'Tidak ada koneksi Internet';
    } catch (e) {
      _state = ProviderState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
