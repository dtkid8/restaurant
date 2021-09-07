import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:restaurant/data/core/api_client.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/utils/notification_helper.dart';
import 'package:http/http.dart' show Client;
final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiClient(client: Client()).getListRestaurant();
    final random = Random();
    final index = random.nextInt(result.restaurants.length-1);
    final restaurant = result.restaurants[index];
    await _notificationHelper.showNotification(flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
