import 'package:eseosport_app/presentation/viewmodels/activity_viewmodel.dart';
import 'package:eseosport_app/presentation/views/activity/activities_page.dart';
import 'package:eseosport_app/presentation/views/activity/no_activity_page.dart';
import 'package:eseosport_app/presentation/views/record/record_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/ activity_repository.dart';
import 'data/repositories/bluetooth_repository.dart';
import 'presentation/viewmodels/live_data_viewmodel.dart';
import 'presentation/views/splash_screen.dart';
import 'presentation/views/home_page.dart';
import 'presentation/views/record/save_activity_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LiveDataViewModel(BluetoothRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityViewModel(ActivityRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ESEOSPORT',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        routes: {
          '/home': (context) => HomePage(),
          '/record': (context) => const RecordPage(),
          '/profile': (context) => NoActivityPage(),
          '/saveActivity': (context) => const SaveActivityPage(),
          'activities': (context) => const ActivitiesPage(),
        },
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}