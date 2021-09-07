import 'package:flutter/material.dart';
import 'package:restaurant/common/navigation.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/screen/restaurant_detail_screen.dart';

class RestaurantListTile extends StatelessWidget {
  final Restaurants restaurant;
  const RestaurantListTile({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        "https://restaurant-api.dicoding.dev/images/large/"+restaurant.pictureId.toString(),
        width: 100,
      ),
      title: Text(
        restaurant.name,
      ),
      subtitle: Text(restaurant.city),
      onTap: () {
        // Navigator.pushNamed(context, RestaurantDetailScreen.routeName, arguments: restaurant);
         Navigation.intentWithData(RestaurantDetailScreen.routeName, restaurant);
      },
    );
  }
}
