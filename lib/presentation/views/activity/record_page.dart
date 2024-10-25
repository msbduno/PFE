import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../viewmodels/live_data_viewmodel.dart';
import '../../widgets/live_data_display.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool _isRecording = false;


  @override
  void initState() {
    super.initState();
    Provider.of<LiveDataViewModel>(context, listen: false).initialize();
  }

  @override
  void dispose() {
    Provider.of<LiveDataViewModel>(context, listen: false).stopReceivingData();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    Provider.of<LiveDataViewModel>(context, listen: false).startReceivingData();
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    Provider.of<LiveDataViewModel>(context, listen: false).stopReceivingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '00:00:00',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          LiveDataDisplay(), // Afficher les données en direct
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.green : Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(_isRecording ? 'Stop' : 'Start'),
            ),
          ),
        ],
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
