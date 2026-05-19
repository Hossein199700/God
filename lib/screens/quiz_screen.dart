import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/question_service.dart';

class QuizScreen extends StatefulWidget {

  final UserModel user;

  const QuizScreen({
    super.key,
    required this.user,
  });

  @override
  State<QuizScreen> createState() =>
      _QuizScreenState();

}

class _QuizScreenState
    extends State<QuizScreen> {

  late Question currentQuestion;

  final answerController =
      TextEditingController();

  int streak = 0;

  String result = "";

  @override
  void initState() {

    super.initState();

    currentQuestion =
        QuestionService.generate();

  }

  void nextQuestion(){

    setState(() {

      answerController.clear();

      result = "";

      currentQuestion =
          QuestionService.generate();

    });

  }

  void submit(){

    int? userAnswer =
        int.tryParse(
            answerController.text);

    if(userAnswer==null){

      setState(() {

        result =
        "عدد معتبر وارد کن";

      });

      return;

    }

    if(userAnswer==
        currentQuestion.answer){

      streak++;

      widget.user.score += 15;

      if(streak>=5){

        widget.user.cups +=1;

      }

      setState(() {

        result =
        "✅ پاسخ صحیح";

      });

    }else{

      streak=0;

      setState(() {

        result =
        "❌ غلط | جواب: ${currentQuestion.answer}";

      });

    }

    Future.delayed(

      const Duration(
        seconds:2,
      ),

          (){

        nextQuestion();

      },

    );

  }

  Color difficultyColor(){

    if(currentQuestion
        .difficulty=="HARD"){

      return Colors.red;

    }

    return Colors.orange;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Infinite Quiz",
        ),

      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Card(

              color:
              Colors.green.shade50,

              child: Padding(

                padding:
                const EdgeInsets.all(16),

                child: Column(

                  children: [

                    Text(

                      widget.user.username,

                      style:
                      const TextStyle(

                        fontSize:22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:12,
                    ),

                    Text(
                      "⭐ Score: ${widget.user.score}",
                    ),

                    Text(
                      "🏆 Cups: ${widget.user.cups}",
                    ),

                    Text(
                      "🔥 Streak: $streak",
                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(
              height:25,
            ),

            Container(

              padding:
              const EdgeInsets.all(10),

              decoration:
              BoxDecoration(

                color:
                difficultyColor(),

                borderRadius:
                BorderRadius.circular(
                  12,
                ),

              ),

              child: Text(

                currentQuestion
                    .difficulty,

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

              elevation:5,

              child: Padding(

                padding:
                const EdgeInsets.all(25),

                child: Column(

                  children: [

                    Text(

                      currentQuestion
                          .question,

                      textAlign:
                      TextAlign.center,

                      style:
                      const TextStyle(

                        fontSize:28,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(
                      height:30,
                    ),

                    TextField(

                      controller:
                      answerController,

                      keyboardType:
                      TextInputType.number,

                      decoration:
                      const InputDecoration(

                        labelText:
                        "جواب",

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
                        submit,

                        child:
                        const Text(
                          "ثبت پاسخ",
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

            Text(

              result,

              style:
              const TextStyle(

                fontSize:20,

                fontWeight:
                FontWeight.bold,

              ),

            ),

          ],

        ),

      ),

    );

  }

}
