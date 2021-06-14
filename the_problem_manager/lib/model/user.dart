class User {
  String email = "";
  String password = "";

  Map<String, Object> toMap() {
    return {
      propEmail: email,
      propPassword: password,
    };
  }

  User.fromMap(map) {
    this.email = map[propEmail];
    this.password = map[propPassword];
  }

  User();

  static String label = "api-auth";
  static String propEmail = "email";
  static String propPassword = "password";
}