class Hospital {
  late int id;
  late String hospitalCode;
  late String name;
  late String address;
  late String description;
  late double lat;
  late double long;

  Hospital(
      {required this.id,
        required this.hospitalCode,
        required this.name,
        required this.address,
        required this.description,
        required this.lat,
        required this.long});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalCode = json['hospitalCode'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospitalCode'] = this.hospitalCode;
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
