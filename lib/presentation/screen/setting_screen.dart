import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/provider/scheduling/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurant_setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text('Scheduling News'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                      scheduled.scheduledNews(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
