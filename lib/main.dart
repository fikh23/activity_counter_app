import 'package:flutter/material.dart';

import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  final activityData = ActivityData();
  final activityRepository = ActivityRepository(activityData);
  final activityViewModel = ActivityViewModel(activityRepository);

  runApp(ActivityCounterApp(viewModel: activityViewModel));
}

class ActivityCounterApp extends StatelessWidget {
  final ActivityViewModel viewModel;

  const ActivityCounterApp({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F6FA),
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
