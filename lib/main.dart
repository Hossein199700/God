import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();

  await AuthService.seedAdmins();

  runApp(const App());

}

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:false,

      title:"Mathverse School PRO",

      theme: ThemeData(

        useMaterial3:true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),

        scaffoldBackgroundColor:
            Colors.white,

      ),

      home: const LoginScreen(),

    );

  }

}
