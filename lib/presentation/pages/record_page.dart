import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '00:00:00',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          Text('SPEED', style: TextStyle(fontSize: 12)),
                          Text('0.0', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('DISTANCE', style: TextStyle(fontSize: 12)),
                          Text('0.00', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          Text('ELEVATION', style: TextStyle(fontSize: 12)),
                          Text('0', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('BPM', style: TextStyle(fontSize: 12)),
                          Text('0', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Start'),
              onPressed: () {
                // Implement start logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
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