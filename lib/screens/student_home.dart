import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'feedback_screen.dart';

class StudentHome extends StatelessWidget {

  final UserModel user;

  const StudentHome({
    super.key,
    required this.user,
  });

  Color rankColor() {

    if(user.cups>=25){
      return Colors.amber;
    }

    if(user.cups>=10){
      return Colors.grey;
    }

    return Colors.brown;

  }

  String rankTitle(){

    if(user.cups>=25){
      return "GOLD CUP";
    }

    if(user.cups>=10){
      return "SILVER CUP";
    }

    return "BRONZE CUP";

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Mathverse Student",
        ),

        actions: [

          IconButton(

            onPressed:(){

              Navigator.pushReplacement(

                context,

                MaterialPageRoute(

                  builder:(_)=>
                  const LoginScreen(),

                ),

              );

            },

            icon: const Icon(
              Icons.logout,
            ),

          )

        ],

      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            Card(

              color:
              Colors.green.shade50,

              elevation:5,

              child: Padding(

                padding:
                const EdgeInsets.all(18),

                child: Column(

                  children: [

                    CircleAvatar(

                      radius:45,

                      backgroundColor:
                      Colors.green,

                      child: Text(

                        user.username[0]
                            .toUpperCase(),

                        style:
                        const TextStyle(

                          color: Colors.white,

                          fontSize:34,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                    const SizedBox(
                      height:12,
                    ),

                    Text(

                      user.username,

                      style:
                      const TextStyle(

                        fontSize:22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:8,
                    ),

                    Text(
                      user.bio.isEmpty
                          ? "بدون بیوگرافی"
                          : user.bio,
                    ),

                    const SizedBox(
                      height:15,
                    ),

                    Container(

                      padding:
                      const EdgeInsets.all(10),

                      decoration:
                      BoxDecoration(

                        color:
                        rankColor(),

                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),

                      ),

                      child: Text(

                        rankTitle(),

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                    const SizedBox(
                      height:12,
                    ),

                    Text(

                      "⭐ Score : ${user.score}",

                      style:
                      const TextStyle(

                        fontSize:18,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    Text(

                      "🏆 Cups : ${user.cups}",

                      style:
                      const TextStyle(

                        fontSize:18,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:18,
            ),

            menuCard(

              context,

              Icons.person,

              "پ
