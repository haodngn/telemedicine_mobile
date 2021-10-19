class Disease {
  late int id;
  late String diseaseCode;
  late String name;
  late String description;
  late int diseaseGroupId;
  late bool isActive;
  late String diseaseGroup;

  Disease(
      {required this.id,
      required this.diseaseCode,
      required this.name,
      required this.description,
      required this.diseaseGroupId,
      required this.isActive,
      required this.diseaseGroup});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseCode = json['diseaseCode'];
    name = json['name'];
    description = json['description'];
    diseaseGroupId = json['diseaseGroupId'];
    isActive = json['isActive'];
    diseaseGroup = json['diseaseGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diseaseCode'] = this.diseaseCode;
    data['name'] = this.name;
    data['description'] = this.description;
    data['diseaseGroupId'] = this.diseaseGroupId;
    data['isActive'] = this.isActive;
    data['diseaseGroup'] = this.diseaseGroup;
    return data;
  }
}
