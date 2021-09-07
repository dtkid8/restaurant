import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/provider/state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiClient apiClient;

  RestaurantSearchProvider({
    required this.apiClient,
  });

  late Restaurant _restaurant;
  String _message = "";
  ProviderState _state = ProviderState.NoData;

  String get message => _message;

  Restaurant get result => _restaurant;

  ProviderState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
  if(query!=""){
      try {
        _state = ProviderState.Loading;
        notifyListeners();
        final restaurant = await apiClient.getSearchRestaurant(query);
        if (restaurant.restaurants.isEmpty) {
          _state = ProviderState.NoData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ProviderState.HasData;
          notifyListeners();
          return _restaurant = restaurant;
        }
      } 
      on SocketException {
      _state = ProviderState.Error;
      notifyListeners();
      return _message = 'Tidak ada koneksi Internet';
    } 
      catch (e) {
        _state = ProviderState.Error;
        notifyListeners();
        return _message = 'Error --> $e';
      }
    }
  }
}
