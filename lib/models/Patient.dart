class Patient {
  late String pid;
  late String email;
  late String backgroundDisease;
  late String allergy;
  late String bloodGroup;

  String get getPID => pid;
  set setPID(String pid) => this.pid = pid;

  String get getEmail => email;
  set setEmail(String email) => this.email = email;

  String get getBackgroundDisease => backgroundDisease;
  set setBackgroundDisease(String backgroundDisease) => this.backgroundDisease = backgroundDisease;

  String get getAllergy => allergy;
  set setAllergy(String allergy) => this.allergy = allergy;

  String get getBloodGroup => bloodGroup;
  set setBloodGroup(String bloodGroup) => this.bloodGroup = bloodGroup;
}