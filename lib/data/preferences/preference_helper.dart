import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const SCHEDULER = 'SCHEDULER';

  Future<bool> get isScheduled async {
    final prefs = await sharedPreferences;
    return prefs.getBool(SCHEDULER) ?? false;
  }

  void setScheduler(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(SCHEDULER, value);
  }
}