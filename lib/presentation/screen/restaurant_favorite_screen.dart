import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/provider/restaurant_favorite/restaurant_favorite_provider.dart';
import 'package:restaurant/presentation/provider/state.dart';
import 'package:restaurant/presentation/widget/restaurant_list_tile.dart';

class RestaurantFavoriteScreen extends StatelessWidget {
  const RestaurantFavoriteScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurant_favorite';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
          final restaurant = provider.restaurants;
          if (provider.state == ProviderState.HasData) {
            return ListView.builder(
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantListTile(restaurant: restaurant[index]);
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
