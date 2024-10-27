import 'package:eseosport_app/presentation/views/activity/activities_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../viewmodels/activity_viewmodel.dart';
import '../../widgets/custom_bottom_nav_bar.dart';


class NoActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activityViewModel = Provider.of<ActivityViewModel>(context);

    // Check if there are any activities
    if (activityViewModel.activities.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ActivitiesPage()),
        );
      });

    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Activities',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                'You don\'t have any activities ...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 400),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(350, 40),
                ),
                child: const Text('Record an activity'),
                onPressed: () {
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