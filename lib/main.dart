import 'package:eseosport_app/presentation/views/activity/record_page.dart';
import 'package:eseosport_app/presentation/views/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodels/live_data_viewmodel.dart';
import 'presentation/views/splash_screen.dart';
import 'presentation/views/home_page.dart';
import 'data/repositories/bluetooth_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

void main() {
  // Assurez-vous que les liaisons Flutter sont initialisées
  WidgetsFlutterBinding.ensureInitialized();

  // Créer une instance du BluetoothRepository
  final bluetoothRepository = BluetoothRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LiveDataViewModel(bluetoothRepository),
        ),
        // Vous pouvez ajouter d'autres providers ici si nécessaire
      ],
      child: const MyApp(),
    ),
  );
}