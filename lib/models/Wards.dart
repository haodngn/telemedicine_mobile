class Wards {
  String name="";
  int code=1;
  String codename="";
  String divisionType="";
  String shortCodename="";

  Wards(
      {required this.name,
        required this.code,
        required this.codename,
        required this.divisionType,
        required this.shortCodename});

  Wards.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    shortCodename = json['short_codename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['codename'] = this.codename;
    data['division_type'] = this.divisionType;
    data['short_codename'] = this.shortCodename;
    return data;
  }
}