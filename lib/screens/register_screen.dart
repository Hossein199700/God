import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen
    extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();

}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final userController =
      TextEditingController();

  final passController =
      TextEditingController();

  String message = "";

  Future<void> register() async {

    String username =
        userController.text.trim();

    String password =
        passController.text.trim();

    if(username.isEmpty ||
        password.isEmpty){

      setState(() {

        message =
        "تمام فیلدها الزامی است";

      });

      return;

    }

    await AuthService.registerStudent(
      username,
      password,
    );

    setState(() {

      message =
      "ثبت نام موفق";

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("ثبت نام"),
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
              userController,

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
              passController,

              obscureText:true,

              decoration:
              const InputDecoration(

                labelText:
                "رمز عبور",

                border:
                OutlineInputBorder(),

              ),

            ),

            const SizedBox(height:20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: register,

                child:
                const Text(
                  "ثبت نام",
                ),

              ),

            ),

            const SizedBox(height:10),

            Text(
              message,
            )

          ],

        ),

      ),

    );

  }

}
