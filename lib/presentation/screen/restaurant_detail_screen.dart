import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/provider/restaurant_detail/restaurant_detail_provider.dart';
import 'package:restaurant/presentation/provider/restaurant_favorite/restaurant_favorite_provider.dart';
import 'package:restaurant/presentation/provider/state.dart';

class RestaurantDetailScreen extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurants restaurant;

  const RestaurantDetailScreen({required this.restaurant});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiClient: ApiClient(client: Client()),
        idRestaurant: widget.restaurant.id,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant App'),
          actions: [
            Consumer<RestaurantFavoriteProvider>(
              builder: (context, state, _) {
                return FutureBuilder<bool>(
                  future: state.isFavorite(widget.restaurant.id),
                  builder: (context, snapshot) {
                    var isFavorite = snapshot.data ?? false;
                    return isFavorite
                        ? IconButton(
                            onPressed: () {
                              state.removeRestaurant(widget.restaurant.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              state.addRestaurant(widget.restaurant);
                            },
                            icon: Icon(
                              Icons.favorite_border_outlined,
                            ),
                          );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ProviderState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ProviderState.HasData) {
                return Column(
                  children: [
                    Hero(
                      tag: state.result.restaurant!.pictureId,
                      child: Image.network("https://restaurant-api.dicoding.dev/images/large/"+widget.restaurant.pictureId),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Divider(color: Colors.grey),
                          Text(
                            'Kota: ${state.result.restaurant!.city}',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            'Rating: ${state.result.restaurant!.rating}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Divider(color: Colors.grey),
                          Text(
                            'Makanan',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          for (var food in state.result.restaurant!.menus!.foods)
                            Text(
                              '${food.name}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          Divider(color: Colors.grey),
                          Text(
                            'Minuman',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          for (var drink in state.result.restaurant!.menus!.drinks)
                            Text(
                              '${drink.name}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          Divider(color: Colors.grey),
                          Text(
                            state.result.restaurant!.description,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}

// FutureBuilder<bool>(
//                   future: state.isFavorite(widget.restaurant.id),
//                   builder: context,snapshot,){
//                   return 