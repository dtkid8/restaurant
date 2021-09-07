import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/data/model/restaurant_detail.dart';
import 'package:restaurant/presentation/provider/state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiClient apiClient;
  final String idRestaurant;
  RestaurantDetailProvider({
    required this.apiClient,
    required this.idRestaurant,
  }) {
    //_dbHelper = DatabaseHelper();
    _fetchDetailRestaurant();
  }

  late RestaurantDetail _detail;
  String _message = "";
  late ProviderState _state;
  //late DatabaseHelper _dbHelper;
  late bool _isFavorite = false;

  String get message => _message;
  bool get isFavorite => _isFavorite;

  RestaurantDetail get result => _detail;

  ProviderState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ProviderState.Loading;
      notifyListeners();
      //checkFavorite(idRestaurant);
      final detail = await apiClient.getDetailRestaurant(idRestaurant);
      if (detail.restaurant == null) {
        _state = ProviderState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ProviderState.HasData;
        notifyListeners();
        return _detail = detail;
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

  // Future<void> addRestaurant(Restaurants restaurant) async {
  //   await _dbHelper.insertRestaurant(restaurant);
  //   //checkFavorite(restaurant.id);
  //   notifyListeners();
  // }

  // void deleteRestaurant(String id) async {
  //   await _dbHelper.deleteRestaurant(id);
  //   //checkFavorite(id);
  //   notifyListeners();
  // }

  // Future<void> checkFavorite(String id) async {
  //   final check = await _dbHelper.checkRestaurant(id);
  //   if (check.isNotEmpty) {
  //     _isFavorite = true;
  //   } else {
  //     _isFavorite = false;
  //   }
  // }
}
