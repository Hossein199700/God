import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'register_screen.dart';
import 'student_home.dart';
import 'admin_panel.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();

}

class _LoginScreenState
    extends State<LoginScreen> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  String error = "";

  void login() {

    UserModel? user =
        AuthService.login(

      usernameController.text.trim(),

      passwordController.text.trim(),

    );

    if(user==null){

      setState(() {

        error =
        "نام کاربری یا رمز اشتباه است";

      });

      return;

    }

    if(user.role=="admin"){

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>AdminPanel(
            user: user,
          ),

        ),

      );

    }else{

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>StudentHome(
            user: user,
          ),

        ),

      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Mathverse Login",
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            TextField(

              controller:
                  usernameController,

              decoration:
                  const InputDecoration(

                labelText:
                    "نام کاربری",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height:15),

            TextField(

              controller:
                  passwordController,

              obscureText:true,

              decoration:
                  const InputDecoration(

                labelText:"رمز عبور",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height:10),

            Text(
              error,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),

            const SizedBox(height:20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: login,

                child: const Text(
                  "ورود",
                ),

              ),

            ),

            TextButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_)=>
                    const RegisterScreen(),

                  ),

                );

              },

              child: const Text(
                "ثبت نام دانش آموز",
              ),

            )

          ],

        ),

      ),

    );

  }

}
