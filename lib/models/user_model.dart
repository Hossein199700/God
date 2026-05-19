class UserModel {

  String id;

  String username;

  String password;

  String role;

  String bio;

  int score;

  int cups;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    this.bio = "",
    this.score = 0,
    this.cups = 0,
  });

  Map<String,dynamic> toMap() {

    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'bio': bio,
      'score': score,
      'cups': cups,
    };
  }

  factory UserModel.fromMap(Map map) {

    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      role: map['role'],
      bio: map['bio'] ?? "",
      score: map['score'] ?? 0,
      cups: map['cups'] ?? 0,
    );
  }
}
