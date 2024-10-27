import 'package:flutter/material.dart';
import '../../data/models/activity_model.dart';
import '../../data/repositories/ activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _activityRepository;
  List<Activity> _activities = [];
  bool _isLoading = false;
  String? _errorMessage;

  ActivityViewModel(this._activityRepository) {
    fetchActivities(); // Fetch activities when the ViewModel is created
  }

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchActivities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _activities = await _activityRepository.getActivities();
    } catch (e) {
      _errorMessage = 'Une erreur est survenue lors du chargement des activités.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveActivity(Activity activity) async {
    await _activityRepository.saveActivity(activity);
    await fetchActivities(); // Met à jour la liste des activités
  }
}