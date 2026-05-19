import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {

  final UserModel user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();

}

class _ProfileScreenState
    extends State<ProfileScreen> {

  late TextEditingController bioController;

  @override
  void initState() {

    super.initState();

    bioController =
        TextEditingController(
          text: widget.user.bio,
        );

  }

  Future<void> saveBio() async {

    final box =
        Hive.box("users");

    widget.user.bio =
        bioController.text.trim();

    await box.put(

      widget.user.username,

      widget.user.toMap(),

    );

    if(!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "بیوگرافی ذخیره شد",
        ),

      ),

    );

    setState((){});

  }

  String level(){

    if(widget.user.score>=1000){

      return "LEGEND";

    }

    if(widget.user.score>=500){

      return "MASTER";

    }

    if(widget.user.score>=250){

      return "PRO";

    }

    return "STARTER";

  }

  Color badgeColor(){

    if(widget.user.score>=1000){

      return Colors.amber;

    }

    if(widget.user.score>=500){

      return Colors.purple;

    }

    if(widget.user.score>=250){

      return Colors.blue;

    }

    return Colors.green;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Profile",
        ),

      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            CircleAvatar(

              radius:55,

              backgroundColor:
              Colors.green,

              child: Text(

                widget.user
                    .username[0]
                    .toUpperCase(),

                style:
                const TextStyle(

                  color:
                  Colors.white,

                  fontSize:42,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

            ),

            const SizedBox(
              height:15,
            ),

            Text(

              widget.user.username,

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

            Container(

              padding:
              const EdgeInsets.symmetric(

                horizontal:16,

                vertical:8,

              ),

              decoration:
              BoxDecoration(

                color:
                badgeColor(),

                borderRadius:
                BorderRadius.circular(
                  15,
                ),

              ),

              child: Text(

                level(),

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
              height:25,
            ),

            Card(

              child: Padding(

                padding:
                const EdgeInsets.all(18),

                child: Column(

                  children: [

                    TextField(

                      controller:
                      bioController,

                      maxLines:5,

                      decoration:
                      const InputDecoration(

                        labelText:
                        "بیوگرافی",

                        border:
                        OutlineInputBorder(),

                      ),

                    ),

                    const SizedBox(
                      height:20,
                    ),

                    SizedBox(

                      width:
                      double.infinity,

                      child:
                      ElevatedButton(

                        onPressed:
                        saveBio,

                        child:
                        const Text(
                          "ذخیره بیوگرافی",
                        ),

                      ),

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:20,
            ),

            Card(

              color:
              Colors.green.shade50,

              child: Padding(

                padding:
                const EdgeInsets.all(18),

                child: Column(

                  children: [

                    statRow(
                      "⭐ Score",
                      widget.user.score
                          .toString(),
                    ),

                    statRow(
                      "🏆 Cups",
                      widget.user.cups
                          .toString(),
                    ),

                    statRow(
                      "👤 Role",
                      widget.user.role,
                    ),

                  ],

                ),

              ),

            )

          ],

        ),

      ),

    );

  }

  Widget statRow(
      String title,
      String value,
      ){

    return Padding(

      padding:
      const EdgeInsets.symmetric(
        vertical:10,
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
              fontSize:18,
            ),

          )

        ],

      ),

    );

  }

}
