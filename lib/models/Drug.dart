import 'package:telemedicine_mobile/models/DrugType.dart';

class Drug {
  late int id;
  late String name;
  late String producer;
  late String drugOrigin;
  late String drugForm;
  late bool isActive;
  late DrugType drugType;
  late int drugTypeId;

  Drug(
      {required this.id,
      required this.name,
      required this.producer,
      required this.drugOrigin,
      required this.drugForm,
      required this.isActive,
      required this.drugType,
      required this.drugTypeId});

  Drug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    producer = json['producer'];
    drugOrigin = json['drugOrigin'];
    drugForm = json['drugForm'];
    isActive = json['isActive'];

    if (json['drugType'] != null) {
      drugType = new DrugType.fromJson(json['drugType']);
    } else {
      drugType = new DrugType(id: 0, name: "", description: "", isActive: true);
    }
    drugTypeId = json['drugTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['producer'] = this.producer;
    data['drugOrigin'] = this.drugOrigin;
    data['drugForm'] = this.drugForm;
    data['isActive'] = this.isActive;
    if (this.drugType != null) {
      data['drugType'] = this.drugType.toJson();
    }
    data['drugTypeId'] = this.drugTypeId;
    return data;
  }
}
