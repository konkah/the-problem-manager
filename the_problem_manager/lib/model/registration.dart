class Registration {
  int id = 0;
  String name = "";
  String personName = "";
  bool samePerson = false;
  String email = "";
  String password = "";

  Map<String, Object> toMap() {
    return {
      propName: name,
      propPersonName: personName,
      propSamePerson: samePerson,
      propEmail: email,
      propPassword: password,
    };
  }

  Registration.fromMap(map) {
    this.id = map[propId];
    this.name = map[propName];
    this.personName = map[propPersonName];
    this.samePerson = map[propSamePerson];
    this.email = map[propEmail];
    this.password = map[propPassword];
  }

  Registration();

  static String label = "registrations";
  static String propId = "id";
  static String propName = "name";
  static String propPersonName = "personName";
  static String propSamePerson = "samePerson";
  static String propEmail = "email";
  static String propPassword = "password";
}
