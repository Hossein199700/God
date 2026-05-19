import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class AuthService {

  static final box = Hive.box("users");

  static Future<void> seedAdmins() async {

    if(box.isEmpty){

      await registerAdmin(
        "Hossein_1997",
        "1234567",
      );

      await registerAdmin(
        "AmirAli_1997",
        "1234567",
      );

    }

  }

  static Future<void> registerStudent(
      String username,
      String password,
      ) async {

    UserModel user = UserModel(

      id: const Uuid().v4(),

      username: username,

      password: password,

      role: "student",

    );

    await box.put(
      username,
      user.toMap(),
    );

  }

  static Future<void> registerAdmin(
      String username,
      String password,
      ) async {

    UserModel user = UserModel(

      id: const Uuid().v4(),

      username: username,

      password: password,

      role: "admin",

    );

    await box.put(
      username,
      user.toMap(),
    );

  }

  static UserModel? login(
      String username,
      String password,
      ){

    final data = box.get(username);

    if(data==null) return null;

    UserModel user =
        UserModel.fromMap(data);

    if(user.password != password){
      return null;
    }

    return user;

  }

}
