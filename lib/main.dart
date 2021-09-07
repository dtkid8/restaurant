import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/common/navigation.dart';
import 'package:restaurant/data/database/database_helper.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/preferences/preference_helper.dart';
import 'package:restaurant/presentation/provider/restaurant_favorite/restaurant_favorite_provider.dart';
import 'package:restaurant/presentation/provider/scheduling/scheduling_provider.dart';
import 'package:restaurant/presentation/screen/restaurant_detail_screen.dart';
import 'package:restaurant/presentation/screen/restaurant_favorite_screen.dart';
import 'package:restaurant/presentation/screen/restaurant_list_screen.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/presentation/screen/restaurant_search_screen.dart';
import 'package:restaurant/presentation/screen/setting_screen.dart';
import 'package:restaurant/utils/background_service.dart';
import 'package:restaurant/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  //if (Platform.isAndroid) {
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  //}
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantFavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(
            preferencesHelper:
                PreferencesHelper(sharedPreferences: SharedPreferences.getInstance()),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            textTheme: myTextTheme.apply(bodyColor: Colors.white),
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: secondaryColor,
              textStyle: TextStyle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        initialRoute: RestaurantListScreen.routeName,
        routes: {
          RestaurantListScreen.routeName: (context) => RestaurantListScreen(),
          RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
                restaurant: ModalRoute.of(context)?.settings.arguments as Restaurants,
              ),
          RestaurantSearchScreen.routeName: (context) => RestaurantSearchScreen(),
          RestaurantFavoriteScreen.routeName: (context) => RestaurantFavoriteScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
        },
      ),
    );
  }
}
