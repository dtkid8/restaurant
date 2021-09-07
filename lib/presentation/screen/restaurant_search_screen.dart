import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/presentation/provider/restaurant_search/restaurant_search_provider.dart';
import 'package:restaurant/presentation/provider/state.dart';
import 'package:restaurant/presentation/widget/restaurant_list_tile.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurant_search';
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(
        apiClient: ApiClient(client: Client()),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<RestaurantSearchProvider>(
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Masukkan Pencarian',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              state.fetchSearchRestaurant(textController.text);
                            },
                            child: Text(
                              "Cari",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Consumer<RestaurantSearchProvider>(
                    builder: (context, state, _) {
                      if (state.state == ProviderState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.state == ProviderState.HasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// if (state.state == ProviderState.Loading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state.state == ProviderState.HasData) {
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         TextField(
//                           controller: textController,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'Masukkan Pencarian',
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             state.fetchSearchRestaurant(textController.text);
//                           },
//                           child: Text(
//                             "Cari",
//                           ),
//                         ),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: state.result.restaurants.length,
//                           itemBuilder: (context, index) {
//                             final restaurant = state.result.restaurants[index];
//                             return RestaurantListTile(restaurant: restaurant);
//                           },
//                         )
//                       ],
//                     ),
//                   );
//                 } else if (state.state == ProviderState.NoData) {
//                   return Column(
//                     children: [
//                       TextField(
//                         controller: textController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Masukkan Pencarian',
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           state.fetchSearchRestaurant(textController.text);
//                         },
//                         child: Text(
//                           "Cari",
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (state.state == ProviderState.Error) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return Center(child: Text(''));
//                 }
//               },