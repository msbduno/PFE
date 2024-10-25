import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(
            color: Colors.black, // Change text color if needed
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: Container(
        color: Colors.grey[300], // Set the background color here
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                'You don\'t have any activities ...',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),

              ),
              const SizedBox(height: 400), // Space below the text
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(350, 40), // Set the minimum size for the button
                ),
                child: const Text('Record an activity'),
                onPressed: () {
                  // Navigate to record page
                  Navigator.pushReplacementNamed(context, '/record');
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/record');
          }
        },
      ),
    );
  }
}
