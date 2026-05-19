import 'package:flutter/material.dart';

import '../models/user_model.dart';

import 'quiz_screen.dart';
import 'profile_screen.dart';
import 'feedback_screen.dart';
import 'leaderboard_screen.dart';
import 'admin_panel.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {

  final UserModel user;

  const HomeScreen({

    super.key,

    required this.user,

  });

  @override
  Widget build(
      BuildContext context,
      ){

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "MathVerse",
        ),

        actions:[

          IconButton(

            onPressed:(){

              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(

                  builder:(context)=>

                  const LoginScreen(),

                ),

                    (route)=>false,

              );

            },

            icon:
            const Icon(
              Icons.logout,
            ),

          )

        ],

      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(

          children:[

            Card(

              color:
              Colors.green.shade50,

              child: Padding(

                padding:
                const EdgeInsets.all(
                  18,
                ),

                child: Column(

                  children:[

                    CircleAvatar(

                      radius:42,

                      backgroundColor:
                      Colors.green,

                      child: Text(

                        user.username[0]
                            .toUpperCase(),

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontSize:30,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                    const SizedBox(
                      height:14,
                    ),

                    Text(

                      "سلام ${user.username}",

                      style:
                      const TextStyle(

                        fontSize:24,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:10,
                    ),

                    Text(
                      user.role
                          .toUpperCase(),
                    ),

                    const SizedBox(
                      height:12,
                    ),

                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceEvenly,

                      children:[

                        statBox(

                          "Score",

                          user.score
                              .toString(),

                        ),

                        statBox(

                          "Cups",

                          user.cups
                              .toString(),

                        ),

                      ],

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:25,
            ),

            menuButton(

              context,

              Icons.quiz,

              "Infinite Quiz",

                  (){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>

                    QuizScreen(
                      user:user,
                    ),

                  ),

                );

              },

            ),

            menuButton(

              context,

              Icons.person,

              "Profile",

                  (){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>

                    ProfileScreen(
                      user:user,
                    ),

                  ),

                );

              },

            ),

            menuButton(

              context,

              Icons.leaderboard,

              "Leaderboard",

                  (){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>

                    const LeaderboardScreen(),

                  ),

                );

              },

            ),

            menuButton(

              context,

              Icons.feedback,

              "Feedback",

                  (){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>

                    FeedbackScreen(
                      user:user,
                    ),

                  ),

                );

              },

            ),

            if(user.role=="admin")

              menuButton(

                context,

                Icons.admin_panel_settings,

                "Admin Panel",

                    (){

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(context)=>

                      AdminPanel(
                        user:user,
                      ),

                    ),

                  );

                },

              )

          ],

        ),

      ),

    );

  }

  Widget menuButton(

      BuildContext context,

      IconData icon,

      String title,

      VoidCallback onTap,

      ){

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom:16,
      ),

      child: SizedBox(

        width:
        double.infinity,

        child:
        ElevatedButton.icon(

          style:
          ElevatedButton.styleFrom(

            padding:
            const EdgeInsets.all(
              18,
            ),

            backgroundColor:
            Colors.green,

          ),

          onPressed:onTap,

          icon:
          Icon(
            icon,
            color: Colors.white,
          ),

          label:
          Text(

            title,

            style:
            const TextStyle(

              color:
              Colors.white,

              fontSize:18,

            ),

          ),

        ),

      ),

    );

  }

  Widget statBox(
      String title,
      String value,
      ){

    return Container(

      width:120,

      padding:
      const EdgeInsets.all(
        12,
      ),

      decoration:
      BoxDecoration(

        color:
        Colors.white,

        borderRadius:
        BorderRadius.circular(
          14,
        ),

      ),

      child: Column(

        children:[

          Text(

            title,

            style:
            const TextStyle(

              fontWeight:
              FontWeight.bold,

            ),

          ),

          const SizedBox(
            height:8,
          ),

          Text(

            value,

            style:
            const TextStyle(

              fontSize:22,

              color:
              Colors.green,

              fontWeight:
              FontWeight.bold,

            ),

          )

        ],

      ),

    );

  }

}
