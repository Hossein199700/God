import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class AdminPanel extends StatefulWidget {

  final UserModel user;

  const AdminPanel({
    super.key,
    required this.user,
  });

  @override
  State<AdminPanel> createState() =>
      _AdminPanelState();

}

class _AdminPanelState
    extends State<AdminPanel> {

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

    setState((){});

  }

  Future<void> makeAdmin(
      UserModel user,
      ) async {

    final box =
        Hive.box("users");

    user.role="admin";

    await box.put(

      user.username,

      user.toMap(),

    );

    loadUsers();

  }

  Future<void> deleteUser(
      UserModel user,
      ) async {

    if(user.role=="admin"){

      return;

    }

    final box =
        Hive.box("users");

    await box.delete(
      user.username,
    );

    loadUsers();

  }

  int totalAdmins(){

    return users

        .where(
          (e)=>e.role=="admin",
        )

        .length;

  }

  int totalStudents(){

    return users

        .where(
          (e)=>e.role=="student",
        )

        .length;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Admin Panel",
        ),

        backgroundColor:
        Colors.green,

      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            Card(

              color:
              Colors.green.shade50,

              child: Padding(

                padding:
                const EdgeInsets.all(18),

                child: Column(

                  children: [

                    const Text(

                      "SYSTEM DASHBOARD",

                      style:
                      TextStyle(

                        fontSize:24,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:15,
                    ),

                    statCard(

                      "کل کاربران",

                      users.length
                          .toString(),

                    ),

                    statCard(

                      "دانش آموزها",

                      totalStudents()
                          .toString(),

                    ),

                    statCard(

                      "مدیرها",

                      totalAdmins()
                          .toString(),

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:20,
            ),

            const Align(

              alignment:
              Alignment.centerLeft,

              child: Text(

                "Users",

                style:
                TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

            ),

            const SizedBox(
              height:10,
            ),

            ...users.map(

                  (user){

                return Card(

                  child: ListTile(

                    leading:

                    CircleAvatar(

                      backgroundColor:

                      user.role=="admin"

                          ? Colors.red

                          : Colors.green,

                      child: Text(

                        user.username[0]
                            .toUpperCase(),

                      ),

                    ),

                    title:
                    Text(
                      user.username,
                    ),

                    subtitle:
                    Text(

                      "${user.role} | Score:${user.score}",

                    ),

                    trailing:

                    PopupMenuButton(

                      itemBuilder:(context)=>[

                        if(user.role
                            =="student")

                          const PopupMenuItem(

                            value:"admin",

                            child: Text(
                              "Make Admin",
                            ),

                          ),

                        if(user.role
                            =="student")

                          const PopupMenuItem(

                            value:"delete",

                            child: Text(
                              "Delete",
                            ),

                          ),

                      ],

                      onSelected:(value){

                        if(value
                            =="admin"){

                          makeAdmin(
                            user,
                          );

                        }

                        if(value
                            =="delete"){

                          deleteUser(
                            user,
                          );

                        }

                      },

                    ),

                  ),

                );

              },

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
                loadUsers,

                child:
                const Text(
                  "Refresh",
                ),

              ),

            )

          ],

        ),

      ),

    );

  }

  Widget statCard(
      String title,
      String value,
      ){

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom:12,
      ),

      child: Container(

        width:
        double.infinity,

        padding:
        const EdgeInsets.all(16),

        decoration:
        BoxDecoration(

          color:
          Colors.white,

          borderRadius:
          BorderRadius.circular(
            14,
          ),

        ),

        child: Row(

          mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

          children: [

            Text(

              title,

              style:
              const TextStyle(

                fontSize:18,

                fontWeight:
                FontWeight.bold,

              ),

            ),

            Text(

              value,

              style:
              const TextStyle(

                fontSize:20,

                color:
                Colors.green,

                fontWeight:
                FontWeight.bold,

              ),

            )

          ],

        ),

      ),

    );

  }

}
