import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();

}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  Future<void> register()
  async {

    String username =
        usernameController.text
            .trim();

    String password =
        passwordController.text
            .trim();

    if(username.isEmpty
        || password.isEmpty){

      showMessage(
        "فیلدها خالی هستند",
      );

      return;

    }

    if(

    username=="Hossein_1997"

        ||

        username=="AmirAli_1997"

    ){

      showMessage(
        "این نام رزرو شده است",
      );

      return;

    }

    final box =
        Hive.box("users");

    if(box.containsKey(
      username,
    )){

      showMessage(
        "نام کاربری موجود است",
      );

      return;

    }

    UserModel user =
    UserModel(

      username:
      username,

      password:
      password,

      role:
      "student",

      bio:"",

      score:0,

      cups:0,

    );

    await box.put(

      username,

      user.toMap(),

    );

    if(!mounted) return;

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder:(context)=>

            HomeScreen(

              user:user,

            ),

      ),

    );

  }

  void showMessage(
      String text,
      ){

    ScaffoldMessenger
        .of(context)

        .showSnackBar(

      SnackBar(

        content:
        Text(text),

      ),

    );

  }

  @override
  Widget build(
      BuildContext context,
      ){

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "ثبت نام",
        ),

      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(
          24,
        ),

        child: Column(

          children: [

            const SizedBox(
              height:30,
            ),

            const Icon(

              Icons.person_add,

              size:90,

              color:
              Colors.green,

            ),

            const SizedBox(
              height:20,
            ),

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

            const SizedBox(
              height:18,
            ),

            TextField(

              controller:
              passwordController,

              obscureText:true,

              decoration:
              const InputDecoration(

                labelText:
                "رمز عبور",

                border:
                OutlineInputBorder(),

              ),

            ),

            const SizedBox(
              height:30,
            ),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                register,

                child:
                const Text(
                  "ساخت حساب",
                ),

              ),

            )

          ],

        ),

      ),

    );

  }

}
