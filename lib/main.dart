import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/login_screen.dart';

void main() async {

  WidgetsFlutterBinding
      .ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(
    "users",
  );

  await Hive.openBox(
    "feedbacks",
  );

  runApp(
    const MathVerse(),
  );

}

class MathVerse
    extends StatelessWidget {

  const MathVerse({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ){

    return MaterialApp(

      debugShowCheckedModeBanner:
      false,

      title:
      "MathVerse",

      theme:
      ThemeData(

        primarySwatch:
        Colors.green,

        scaffoldBackgroundColor:
        Colors.white,

        appBarTheme:
        const AppBarTheme(

          backgroundColor:
          Colors.green,

          foregroundColor:
          Colors.white,

        ),

      ),

      home:
      const LoginScreen(),

    );

  }

}
