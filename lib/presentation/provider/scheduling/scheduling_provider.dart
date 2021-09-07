import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant/data/preferences/preference_helper.dart';
import 'package:restaurant/utils/background_service.dart';
import 'package:restaurant/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getIsScheduled();
  }
  bool get isScheduled => _isScheduled;
  
  void _getIsScheduled() async {
    _isScheduled = await preferencesHelper.isScheduled;
    notifyListeners();
  }
  Future<bool> scheduledNews(bool value) async {
    preferencesHelper.setScheduler(value);
    _isScheduled = await preferencesHelper.isScheduled;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();
      return await 
      AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
      // AndroidAlarmManager.periodic(
      //           Duration(seconds: 60),
      //           1,
      //           BackgroundService.callback,
      //           exact: true,
      //           wakeup: true,
      //         );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}