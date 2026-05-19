class UserModel {

  String username;

  String password;

  String role;

  String bio;

  int score;

  int cups;

  UserModel({

    required this.username,

    required this.password,

    required this.role,

    required this.bio,

    required this.score,

    required this.cups,

  });

  Map<String,dynamic> toMap(){

    return {

      "username":username,

      "password":password,

      "role":role,

      "bio":bio,

      "score":score,

      "cups":cups,

    };

  }

  factory UserModel.fromMap(
      Map<String,dynamic> map){

    return UserModel(

      username:
      map["username"],

      password:
      map["password"],

      role:
      map["role"],

      bio:
      map["bio"] ?? "",

      score:
      map["score"] ?? 0,

      cups:
      map["cups"] ?? 0,

    );

  }

}
