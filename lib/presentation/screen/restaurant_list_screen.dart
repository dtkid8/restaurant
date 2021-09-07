import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurant/presentation/provider/restaurant/restaurant_provider.dart';
import 'package:restaurant/presentation/provider/state.dart';
import 'package:restaurant/presentation/screen/restaurant_detail_screen.dart';
import 'package:restaurant/presentation/screen/restaurant_favorite_screen.dart';
import 'package:restaurant/presentation/screen/restaurant_search_screen.dart';
import 'package:restaurant/presentation/screen/setting_screen.dart';
import 'package:restaurant/presentation/widget/restaurant_list_tile.dart';
import 'package:restaurant/utils/notification_helper.dart';

class RestaurantListScreen extends StatefulWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailScreen.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchScreen.routeName);
              //Navigation.intentWithData(RestaurantSearchScreen.routeName,"");
            },
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantFavoriteScreen.routeName);
              //Navigation.intentWithData(RestaurantSearchScreen.routeName,"");
            },
            icon: Icon(
              Icons.favorite,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SettingScreen.routeName);
            },
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(
          apiClient: ApiClient(client:Client()),
        ),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ProviderState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ProviderState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.result.restaurants[index];
                  return RestaurantListTile(restaurant: restaurant);
                },
              );
            } else if (state.state == ProviderState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ProviderState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
