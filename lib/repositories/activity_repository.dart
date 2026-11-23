import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _activityData;

  ActivityRepository(this._activityData);

  List<ActivityModel> getAllActivities() {
    return List.unmodifiable(_activityData.activities);
  }

  ActivityModel? getActivityById(String id) {
    try {
      return _activityData.activities.firstWhere(
        (activity) => activity.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void addActivity(ActivityModel activity) {
    _activityData.activities.add(activity);
  }

  bool updateActivity(String id, String newName) {
    final activity = getActivityById(id);
    if (activity == null) return false;

    activity.name = newName;
    return true;
  }

  bool deleteActivity(String id) {
    final initialLength = _activityData.activities.length;

    _activityData.activities.removeWhere(
      (activity) => activity.id == id,
    );

    return _activityData.activities.length != initialLength;
  }

  bool changeCounter(String id, int change) {
    final activity = getActivityById(id);
    if (activity == null) return false;

    final newValue = activity.counter + change;
    if (newValue < 0) return false;

    activity.counter = newValue;
    return true;
  }

  bool resetCounter(String id) {
    final activity = getActivityById(id);
    if (activity == null) return false;

    activity.counter = 0;
    return true;
  }
}
