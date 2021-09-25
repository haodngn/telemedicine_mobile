class User {
  late String uid;
  late String email;
  late String firstName;
  late String lastName;
  late String streetAddress;
  late String locality;
  late String city;
  late String postalCode;
  late String phone;
  late DateTime dob;
  late String avatar;
  late bool isMale;
  late bool isActive;
  late String roleID;
  late String noticeID;

  String get getUID => uid;
  set setUID(String uid) => this.uid = uid;

  String get getEmail => email;
  set setEmail(String email) => this.email = email;

  String get getFirstName => firstName;
  set setFirstName(String firstName) => this.firstName = firstName;

  String get getLastName => lastName;
  set setLastName(String lastName) => this.lastName = lastName;

  String get getStreetAddress => streetAddress;
  set setStreetAddress(String email) => this.email = email;

  String get getLocality => locality;
  set setLocality(String locality) => this.locality = locality;

  String get getCity => city;
  set setCity(String city) => this.city = city;

  String get getPostalCode => postalCode;
  set setPostalCode(String postalCode) => this.postalCode = postalCode;

  String get getPhone => phone;
  set setPhone(String phone) => this.phone = phone;

  DateTime get getDOB => dob;
  set setDOB(DateTime dob) => this.dob = dob;

  String get getAvatar => avatar;
  set setAvatar(String avatar) => this.avatar = avatar;

  bool get getIsMale => isMale;
  set setIsMale(bool isMale) => this.isMale = isMale;

  bool get getIsActive => isActive;
  set setIsActive(bool isActive) => this.isActive = isActive;

  String get getRoleID => roleID;
  set setRoleID(String roleID) => this.roleID = roleID;

  String get getNoticeID => noticeID;
  set setNoticeID(String noticeID) => this.noticeID = noticeID;
}