import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_detail_view.dart';
import 'activity_form_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({
    super.key,
    required this.viewModel,
  });

  void _addActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityFormView(
          viewModel: viewModel,
        ),
      ),
    );
  }

  void _editActivity(
    BuildContext context,
    ActivityModel activity,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityFormView(
          viewModel: viewModel,
          activity: activity,
        ),
      ),
    );
  }

  void _openDetail(
    BuildContext context,
    ActivityModel activity,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityDetailView(
          viewModel: viewModel,
          activityId: activity.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity Counter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addActivity(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Aktivitas'),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          final activities = viewModel.activities;

          if (activities.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum Ada Aktivitas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tambahkan aktivitas pertamamu!',
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${activity.counter}'),
                  ),
                  title: Text(
                    activity.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Ketuk untuk melihat detail',
                  ),
                  onTap: () => _openDetail(context, activity),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _editActivity(
                      context,
                      activity,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
