import 'package:the_problem_manager/model/registration.dart';

class User {
  String email = "";
  String password = "";
  int registration = 0;

  Map<String, Object> toMap() {
    return {
      propEmail: email,
      propPassword: password,
      propRegistration: registration,
    };
  }

  User.fromMap(map) {
    this.email = map[propEmail];
    this.password = map[propPassword];
    this.registration = map[propRegistration];
  }

  User.fromRegistration(Registration registration) {
    this.email = registration.email;
    this.password = registration.password;
    this.registration = registration.id;
  }

  User();

  static String label = "user";
  static String propEmail = "email";
  static String propPassword = "password";
  static String propRegistration = "registration";
}