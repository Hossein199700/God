class FeedbackModel {

  String username;

  String message;

  String reply;

  FeedbackModel({

    required this.username,

    required this.message,

    required this.reply,

  });

  Map<String,dynamic> toMap(){

    return {

      "username":username,

      "message":message,

      "reply":reply,

    };

  }

  factory FeedbackModel.fromMap(
      Map<String,dynamic> map){

    return FeedbackModel(

      username:
      map["username"],

      message:
      map["message"],

      reply:
      map["reply"],

    );

  }

}
