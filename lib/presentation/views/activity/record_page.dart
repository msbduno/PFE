import 'package:flutter/material.dart';
import 'dart:async';
import '../../../data/models/activity_model.dart';
import '../../widgets/CircleButton.dart';
import '../../widgets/DataColumn.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../viewmodels/live_data_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool _isRecording = false;
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = '00:00:00';
  Activity? _currentActivity;
  double _cumulativeDistance = 0.0;  // Pour suivre la distance totale

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    Provider.of<LiveDataViewModel>(context, listen: false).initialize();
  }

  @override
  void dispose() {
    if (_isRecording) {
      _timer.cancel();
      _stopwatch.stop();
    }
    Provider.of<LiveDataViewModel>(context, listen: false).stopReceivingData();
    super.dispose();
  }

  int _generateActivityId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void _toggleRecording() {
    if (_isRecording) {
      _saveAndStopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _currentActivity ??= Activity(
          idActivity: _generateActivityId(),
          date: DateTime.now(),
          duration: 0,
          distance: 0.0,
          elevation: 0.0,
          averageSpeed: 0.0,
          averageBPM: 0,
          userId: 1,
        );
    });

    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final liveDataVM = Provider.of<LiveDataViewModel>(context, listen: false);

      // Calculer la distance parcourue en fonction de la vitesse
      double distanceIncrement = (liveDataVM.currentSpeed / 3600) * 0.1; // vitesse en km/h * temps en heures
      _cumulativeDistance += distanceIncrement;

      setState(() {
        _elapsedTime = _formatDuration(_stopwatch.elapsed);

        if (_currentActivity != null) {
          _currentActivity = Activity(
            idActivity: _currentActivity!.idActivity,
            date: _currentActivity!.date,
            duration: _stopwatch.elapsed.inSeconds,
            distance: _cumulativeDistance,
            elevation: liveDataVM.currentAltitude ?? 0.0,
            averageSpeed: liveDataVM.currentSpeed,
            averageBPM: liveDataVM.currentBPM ?? 0,
            userId: _currentActivity!.userId,
          );
        }
      });
    });
    Provider.of<LiveDataViewModel>(context, listen: false).startReceivingData();
  }

  void _saveAndStopRecording() async {
    if (_currentActivity != null) {
      final liveDataVM = Provider.of<LiveDataViewModel>(context, listen: false);

      final finalActivity = Activity(
        idActivity: _currentActivity!.idActivity,
        date: _currentActivity!.date,
        duration: _stopwatch.elapsed.inSeconds,
        distance: _cumulativeDistance,
        elevation: liveDataVM.currentAltitude ?? 0.0,
        averageSpeed: liveDataVM.currentSpeed,
        averageBPM: liveDataVM.currentBPM ?? 0,
        userId: _currentActivity!.userId,
      );

      // Sauvegarder l'activité
      // await ActivityRepository.saveActivity(finalActivity);
    }

    setState(() {
      _isRecording = false;
    });

    _stopwatch.stop();
    _timer.cancel();
    Provider.of<LiveDataViewModel>(context, listen: false).stopReceivingData();
  }

  void _cancelActivity() {
    setState(() {
      _isRecording = false;
      _currentActivity = null;
      _elapsedTime = '00:00:00';
      _cumulativeDistance = 0.0;
    });

    _stopwatch.stop();
    _stopwatch.reset();
    if (_isRecording) {
      _timer.cancel();
    }
    Provider.of<LiveDataViewModel>(context, listen: false).stopReceivingData();
  }

  void _saveActivityDetails() {
    if (_currentActivity != null) {
      Navigator.pushNamed(context, '/saveActivity', arguments: _currentActivity);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final liveDataVM = Provider.of<LiveDataViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'TIME',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            Text(
              _elapsedTime,
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // Adding padding around the SPEED and DISTANCE data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(55.0), // Adjust the padding value as needed
                  child: buildDataColumn(
                    'SPEED',
                    '${liveDataVM.currentSpeed.toStringAsFixed(1)}',
                    'km/h',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(55.0), // Adjust the padding value as needed
                  child: buildDataColumn(
                    'DISTANCE',
                    '${_cumulativeDistance.toStringAsFixed(1)}',
                    'km',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Adding padding around the ELEVATION and BPM data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(55.0), // Adjust the padding value as needed
                  child: buildDataColumn(
                    'ELEVATION',
                    '${liveDataVM.currentAltitude?.toStringAsFixed(0) ?? "0"}',
                    'm',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(55.0), // Adjust the padding value as needed
                  child: buildDataColumn(
                    'BPM',
                    '${liveDataVM.currentBPM ?? "0"}',
                    '',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(
                  onPressed: _cancelActivity,
                  icon: Icons.close,
                  color: AppTheme.primaryColor,
                ),
                CircleButton(
                  onPressed: _toggleRecording,
                  icon: _isRecording ? Icons.stop : Icons.play_arrow,
                  color: AppTheme.primaryColor,
                  size: 70,
                ),
                CircleButton(
                  onPressed: _saveActivityDetails,
                  icon: Icons.more_horiz,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }

}