import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final String activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  Future<void> _resetCounter(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Counter?'),
        content: const Text(
          'Apakah kamu yakin ingin mengembalikan counter menjadi 0?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.resetCounter(activityId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Counter berhasil di-reset'),
          ),
        );
      }
    }
  }

  Future<void> _deleteActivity(
    BuildContext context,
    ActivityModel activity,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Aktivitas?'),
        content: Text(
          'Apakah kamu yakin ingin menghapus ${activity.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.deleteActivity(activityId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aktivitas berhasil dihapus'),
          ),
        );

        Navigator.pop(context);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final activity = viewModel.getActivity(activityId);

        if (activity == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detail Aktivitas'),
            ),
            body: const Center(
              child: Text('Aktivitas tidak ditemukan'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Aktivitas'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit aktivitas',
                onPressed: () => _editActivity(context, activity),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  activity.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Text('Jumlah Aktivitas'),
                      const SizedBox(height: 12),
                      Text(
                        '${activity.counter}',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final changed =
                              viewModel.incrementCounter(activityId);

                          if (changed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Counter bertambah +1'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          final changed =
                              viewModel.decrementCounter(activityId);

                          if (changed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Counter berkurang -1'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Counter tidak boleh kurang dari 0',
                                ),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.remove),
                        label: const Text('Kurang'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _resetCounter(context),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Counter'),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _deleteActivity(context, activity),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus Aktivitas'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
