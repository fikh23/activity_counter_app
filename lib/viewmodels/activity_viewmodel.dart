import 'package:flutter/foundation.dart';

import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository);

  List<ActivityModel> get activities {
    return _repository.getAllActivities();
  }

  ActivityModel? getActivity(String id) {
    return _repository.getActivityById(id);
  }

  bool addActivity(String name) {
    final cleanName = name.trim();

    if (cleanName.isEmpty) return false;

    final activity = ActivityModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: cleanName,
    );

    _repository.addActivity(activity);
    notifyListeners();
    return true;
  }

  bool updateActivity(String id, String name) {
    final cleanName = name.trim();

    if (cleanName.isEmpty) return false;

    final result = _repository.updateActivity(id, cleanName);

    if (result) notifyListeners();

    return result;
  }

  bool deleteActivity(String id) {
    final result = _repository.deleteActivity(id);

    if (result) notifyListeners();

    return result;
  }

  bool incrementCounter(String id) {
    final result = _repository.changeCounter(id, 1);

    if (result) notifyListeners();

    return result;
  }

  bool decrementCounter(String id) {
    final result = _repository.changeCounter(id, -1);

    if (result) notifyListeners();

    return result;
  }

  bool resetCounter(String id) {
    final result = _repository.resetCounter(id);

    if (result) notifyListeners();

    return result;
  }
}
