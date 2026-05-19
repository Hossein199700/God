import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';
import '../models/feedback_model.dart';

class FeedbackScreen
    extends StatefulWidget {

  final UserModel user;

  const FeedbackScreen({

    super.key,

    required this.user,

  });

  @override
  State<FeedbackScreen> createState() =>
      _FeedbackScreenState();

}

class _FeedbackScreenState
    extends State<FeedbackScreen> {

  final controller =
      TextEditingController();

  List<FeedbackModel> list=[];

  @override
  void initState() {

    super.initState();

    loadFeedbacks();

  }

  void loadFeedbacks(){

    final box =
        Hive.box("feedbacks");

    list = box.values

        .map(

          (e)=>FeedbackModel
              .fromMap(

            Map<String,dynamic>
            .from(e),

          ),

        )

        .toList();

    setState((){});

  }

  Future<void> sendFeedback()
  async {

    if(controller.text
        .trim()
        .isEmpty){

      return;

    }

    final box =
        Hive.box("feedbacks");

    final feedback =
        FeedbackModel(

      username:
      widget.user.username,

      message:
      controller.text.trim(),

      reply:"",

    );

    await box.add(
      feedback.toMap(),
    );

    controller.clear();

    loadFeedbacks();

  }

  Future<void> replyDialog(
      int index,
      FeedbackModel feedback,
      ) async {

    final replyController =
        TextEditingController(
          text: feedback.reply,
        );

    await showDialog(

      context: context,

      builder:(context){

        return AlertDialog(

          title:
          const Text(
            "پاسخ مدیر",
          ),

          content:
          TextField(

            controller:
            replyController,

            maxLines:4,

          ),

          actions:[

            TextButton(

              onPressed:() async {

                feedback.reply =
                    replyController
                        .text;

                final box =
                    Hive.box(
                      "feedbacks",
                    );

                await box.put(

                  index,

                  feedback.toMap(),

                );

                if(mounted){

                  Navigator.pop(
                    context,
                  );

                }

                loadFeedbacks();

              },

              child:
              const Text(
                "ذخیره",
              ),

            )

          ],

        );

      },

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Feedback",
        ),

      ),

      body:
      Column(

        children: [

          if(widget.user.role
              =="student")

            Padding(

              padding:
              const EdgeInsets.all(
                16,
              ),

              child: Column(

                children: [

                  TextField(

                    controller:
                    controller,

                    maxLines:4,

                    decoration:
                    const InputDecoration(

                      labelText:
                      "نظر یا انتقاد",

                      border:
                      OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height:10,
                  ),

                  SizedBox(

                    width:
                    double.infinity,

                    child:
                    ElevatedButton(

                      onPressed:
                      sendFeedback,

                      child:
                      const Text(
                        "ارسال",
                      ),

                    ),

                  )

                ],

              ),

            ),

          Expanded(

            child:
            ListView.builder(

              itemCount:
              list.length,

              itemBuilder:
                  (context,index){

                final feedback =
                list[index];

                return Card(

                  margin:
                  const EdgeInsets.all(
                    10,
                  ),

                  child: Padding(

                    padding:
                    const EdgeInsets.all(
                      16,
                    ),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Text(

                          feedback
                              .username,

                          style:
                          const TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize:18,

                          ),

                        ),

                        const SizedBox(
                          height:8,
                        ),

                        Text(
                          feedback
                              .message,
                        ),

                        const SizedBox(
                          height:12,
                        ),

                        if(feedback.reply
                            .isNotEmpty)

                          Container(

                            width:
                            double.infinity,

                            padding:
                            const EdgeInsets
                                .all(12),

                            decoration:
                            BoxDecoration(

                              color:
                              Colors.green
                                  .shade50,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                12,
                              ),

                            ),

                            child: Text(

                              "پاسخ مدیر:\n${feedback.reply}",

                            ),

                          ),

                        if(widget.user
                            .role
                            =="admin")

                          Align(

                            alignment:
                            Alignment
                                .centerRight,

                            child:
                            TextButton(

                              onPressed:(){

                                replyDialog(

                                  index,

                                  feedback,

                                );

                              },

                              child:
                              const Text(
                                "پاسخ",
                              ),

                            ),

                          )

                      ],

                    ),

                  ),

                );

              },

            ),

          )

        ],

      ),

    );

  }

}
