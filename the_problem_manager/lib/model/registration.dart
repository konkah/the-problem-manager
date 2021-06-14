class Registration {
  int id = 0;
  String yourName = "";
  String personName = "";
  bool samePerson = false;
  String email = "";
  String password = "";

  Map<String, Object> toMap() {
    return {
      propYourName: yourName,
      propPersonName: personName,
      propSamePerson: samePerson,
      propEmail: email,
      propPassword: password,
    };
  }

  Registration.fromMap(map) {
    this.id = map[propId];
    this.yourName = map[propYourName];
    this.personName = map[propPersonName];
    this.samePerson = map[propSamePerson];
    this.email = map[propEmail];
    this.password = map[propPassword];
  }

  Registration();

  static String label = "registrations";
  static String propId = "id";
  static String propYourName = "yourName";
  static String propPersonName = "personName";
  static String propSamePerson = "samePerson";
  static String propEmail = "email";
  static String propPassword = "password";
}
