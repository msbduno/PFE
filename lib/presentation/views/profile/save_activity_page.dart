import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class SaveActivityPage extends StatelessWidget {
  const SaveActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppTheme.primaryColor, // Set the back button color here
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: const Text(
          'save activity',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
