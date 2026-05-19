import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class LeaderboardScreen
    extends StatefulWidget {

  const LeaderboardScreen({
    super.key,
  });

  @override
  State<LeaderboardScreen>
  createState() =>
      _LeaderboardScreenState();

}

class _LeaderboardScreenState
    extends State<LeaderboardScreen> {

  List<UserModel> users=[];

  @override
  void initState() {

    super.initState();

    loadUsers();

  }

  void loadUsers(){

    final box =
        Hive.box("users");

    users = box.values

        .map(

          (e)=>UserModel
              .fromMap(

            Map<String,dynamic>
            .from(e),

          ),

        )

        .toList();

    users.sort(

          (a,b){

        if(b.score!=a.score){

          return b.score
              .compareTo(
            a.score,
          );

        }

        return b.cups
            .compareTo(
          a.cups,
        );

      },

    );

    setState((){});

  }

  Color medalColor(
      int index,
      ){

    if(index==0){

      return Colors.amber;

    }

    if(index==1){

      return Colors.grey;

    }

    if(index==2){

      return Colors.brown;

    }

    return Colors.green;

  }

  String medalText(
      int index,
      ){

    if(index==0){

      return "🥇 GOLD";

    }

    if(index==1){

      return "🥈 SILVER";

    }

    if(index==2){

      return "🥉 BRONZE";

    }

    return "#${index+1}";

  }

  @override
  Widget build(
      BuildContext context,
      ){

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Leaderboard",
        ),

        backgroundColor:
        Colors.green,

      ),

      body:
      RefreshIndicator(

        onRefresh:() async {

          loadUsers();

        },

        child:
        ListView(

          padding:
          const EdgeInsets.all(
            16,
          ),

          children: [

            Card(

              color:
              Colors.green
                  .shade50,

              child: Padding(

                padding:
                const EdgeInsets
                    .all(18),

                child: Column(

                  children: [

                    const Text(

                      "TOP PLAYERS",

                      style:
                      TextStyle(

                        fontSize:24,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:12,
                    ),

                    Text(

                      "Players: ${users.length}",

                      style:
                      const TextStyle(
                        fontSize:18,
                      ),

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:20,
            ),

            ...List.generate(

              users.length,

                  (index){

                final user =
                users[index];

                return Card(

                  elevation:4,

                  child: ListTile(

                    leading:

                    CircleAvatar(

                      backgroundColor:

                      medalColor(
                        index,
                      ),

                      child: Text(

                        "${index+1}",

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                    title:
                    Text(

                      user.username,

                      style:
                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    subtitle:
                    Text(

                      "⭐ ${user.score} | 🏆 ${user.cups}",

                    ),

                    trailing:

                    Container(

                      padding:
                      const EdgeInsets
                          .symmetric(

                        horizontal:12,

                        vertical:8,

                      ),

                      decoration:
                      BoxDecoration(

                        color:
                        medalColor(
                          index,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          12,
                        ),

                      ),

                      child: Text(

                        medalText(
                          index,
                        ),

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

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

}
