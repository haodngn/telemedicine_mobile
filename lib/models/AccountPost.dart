class AccountPost {
  late String email;
  late String firstName;
  late String lastName;
  late String image;
  late String ward;
  late String streetAddress;
  late String locality;
  late String city;
  late String postalCode;
  late String phone;
  late String dob;
  late bool isMale;
  late int roleId;

  AccountPost({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.ward,
    required this.streetAddress,
    required this.locality,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.dob,
    required this.isMale,
    required this.roleId,
  });

  AccountPost.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    ward = json['ward'];
    image = json['image'];
    streetAddress = json['streetAddress'];
    locality = json['locality'];
    city = json['city'];
    postalCode = json['postalCode'];
    phone = json['phone'];
    dob = json['dob'];
    isMale = json['isMale'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['image'] = this.image;
    data['ward'] = this.ward;
    data['streetAddress'] = this.streetAddress;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['isMale'] = this.isMale;
    data['roleId'] = this.roleId;
    return data;
  }
}
