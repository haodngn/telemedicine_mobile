// class Address {
//   String name;
//   int code;
//   String divisionType;
//   String codename;
//   int phoneCode;
//   List<Null> districts;
//
//   Address(
//       {required this.name,
//         required this.code,
//         required this.divisionType,
//         required this.codename,
//         required this.phoneCode,
//         required this.districts});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     code = json['code'];
//     divisionType = json['division_type'];
//     codename = json['codename'];
//     phoneCode = json['phone_code'];
//     if (json['districts'] != null) {
//       districts = new List<Null>();
//       json['districts'].forEach((v) {
//         districts.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['code'] = this.code;
//     data['division_type'] = this.divisionType;
//     data['codename'] = this.codename;
//     data['phone_code'] = this.phoneCode;
//     if (this.districts != null) {
//       data['districts'] = this.districts.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }