import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';
import 'register_screen.dart';
import 'home_screen.dart';

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

  Future<void> login() async {

    String username =
        usernameController.text.trim();

    String password =
        passwordController.text.trim();

    final box =
        Hive.box("users");

    if(

    username=="Hossein_1997"

        &&

        password=="1234567"

    ){

      Navigator.push(

        context,

        MaterialPageRoute(

          builder:(context)=>HomeScreen(

            user: UserModel(

              username:
              "Hossein_1997",

              password:
              "1234567",

              role:"admin",

              bio:"",

              score:0,

              cups:0,

            ),

          ),

        ),

      );

      return;

    }

    if(

    username=="AmirAli_1997"

        &&

        password=="1234567"

    ){

      Navigator.push(

        context,

        MaterialPageRoute(

          builder:(context)=>HomeScreen(

            user: UserModel(

              username:
              "AmirAli_1997",

              password:
              "1234567",

              role:"admin",

              bio:"",

              score:0,

              cups:0,

            ),

          ),

        ),

      );

      return;

    }

    final data =
    box.get(username);

    if(data==null){

      showError(
        "کاربر پیدا نشد",
      );

      return;

    }

    final user =
    UserModel.fromMap(

      Map<String,dynamic>
          .from(data),

    );

    if(user.password
        !=password){

      showError(
        "رمز اشتباه است",
      );

      return;

    }

    Navigator.push(

      context,

      MaterialPageRoute(

        builder:(context)=>

            HomeScreen(

              user:user,

            ),

      ),

    );

  }

  void showError(
      String message,
      ){

    ScaffoldMessenger
        .of(context)

        .showSnackBar(

      SnackBar(

        content:
        Text(message),

      ),

    );

  }

  @override
  Widget build(
      BuildContext context,
      ){

    return Scaffold(

      body:
      Center(

        child:
        SingleChildScrollView(

          padding:
          const EdgeInsets.all(
            24,
          ),

          child: Column(

            children: [

              const Icon(

                Icons.calculate,

                size:90,

                color:
                Colors.green,

              ),

              const SizedBox(
                height:15,
              ),

              const Text(

                "MATHVERSE",

                style:
                TextStyle(

                  fontSize:32,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

              const SizedBox(
                height:35,
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
                height:15,
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
                height:25,
              ),

              SizedBox(

                width:
                double.infinity,

                child:
                ElevatedButton(

                  onPressed:
                  login,

                  child:
                  const Text(
                    "ورود",
                  ),

                ),

              ),

              const SizedBox(
                height:10,
              ),

              TextButton(

                onPressed:(){

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(context)=>

                      const RegisterScreen(),

                    ),

                  );

                },

                child:
                const Text(
                  "ثبت نام دانش آموز",
                ),

              )

            ],

          ),

        ),

      ),

    );

  }

}
