import 'dart:math';

class Question {

  final String question;

  final int answer;

  final String difficulty;

  Question({

    required this.question,

    required this.answer,

    required this.difficulty,

  });

}

class QuestionService {

  static final Random random =
      Random();

  static Question generate(){

    int mode =
        random.nextInt(2);

    if(mode==0){

      return medium();

    }

    return hard();

  }

  static Question medium(){

    int type =
        random.nextInt(4);

    switch(type){

      case 0:

        int a =
            20+random.nextInt(80);

        int b =
            10+random.nextInt(40);

        int c =
            10+random.nextInt(60);

        return Question(

          question:
          "($a × $b) − $c = ?",

          answer:
          (a*b)-c,

          difficulty:
          "MEDIUM",

        );

      case 1:

        int n =
            12+random.nextInt(18);

        int extra =
            random.nextInt(60);

        return Question(

          question:
          "√${n*n} + $extra = ?",

          answer:
          n+extra,

          difficulty:
          "MEDIUM",

        );

      case 2:

        int a =
            2+random.nextInt(8);

        int b =
            10+random.nextInt(25);

        return Question(

          question:
          "(${a}²) + $b = ?",

          answer:
          (a*a)+b,

          difficulty:
          "MEDIUM",

        );

      default:

        int a =
            40+random.nextInt(50);

        int b =
            2+random.nextInt(8);

        int c =
            50+random.nextInt(120);

        return Question(

          question:
          "($a ÷ $b)+$c=?",

          answer:
          (a~/b)+c,

          difficulty:
          "MEDIUM",

        );

    }

  }

  static Question hard(){

    int type =
        random.nextInt(4);

    switch(type){

      case 0:

        int a =
            10+random.nextInt(30);

        int b =
            40+random.nextInt(80);

        return Question(

          question:
          "(${a}²−$b)/2=?",

          answer:
          ((a*a)-b)~/2,

          difficulty:
          "HARD",

        );

      case 1:

        int a =
            100+random.nextInt(60);

        int b =
            20+random.nextInt(40);

        int c =
            10+random.nextInt(30);

        return Question(

          question:
          "($a×$b)+(${c}²)=?",

          answer:
          (a*b)+(c*c),

          difficulty:
          "HARD",

        );

      case 2:

        int root =
            15+random.nextInt(20);

        int a =
            10+random.nextInt(20);

        int b =
            40+random.nextInt(90);

        return Question(

          question:
          "√${root*root}+($a×7)-$b=?",

          answer:
          root+(a*7)-b,

          difficulty:
          "HARD",

        );

      default:

        int a =
            15+random.nextInt(20);

        int b =
            50+random.nextInt(90);

        int c =
            2+random.nextInt(5);

        return Question(

          question:
          "(${a}²-$b)/$c=?",

          answer:
          ((a*a)-b)~/c,

          difficulty:
          "HARD",

        );

    }

  }

}
