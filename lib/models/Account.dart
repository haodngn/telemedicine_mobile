import 'package:telemedicine_mobile/models/Role.dart';

class Account {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String ward;
  late String streetAddress;
  late String locality;
  late String city;
  late String postalCode;
  late String phone;
  late String avatar;
  late String dob;
  late bool active;
  late bool isMale;
  late Role role;
  Account(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.ward,
      required this.streetAddress,
      required this.locality,
      required this.city,
      required this.postalCode,
      required this.phone,
      required this.avatar,
      required this.dob,
      required this.active,
      required this.isMale,
      required this.role});

  Account.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      email = json['email'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      ward = json['ward'];
      streetAddress = json['streetAddress'];
      locality = json['locality'];
      city = json['city'];
      postalCode = json['postalCode'];
      phone = json['phone'];
      avatar = json['avatar'];
      dob = json['dob'];
      active = json['active'];
      isMale = json['isMale'];
      if (json['role'] != null) {
        role = new Role.fromJson(json['role']);
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['ward'] = this.ward;
    data['streetAddress'] = this.streetAddress;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['dob'] = this.dob;
    data['active'] = this.active;
    data['isMale'] = this.isMale;
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    return data;
  }
}
