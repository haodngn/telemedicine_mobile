class Symptom {
  late int id;
  late String symptomCode;
  late String name;
  late String description;

  Symptom({required this.id, required this.symptomCode, required this.name, required this.description});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symptomCode = json['symptomCode'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symptomCode'] = this.symptomCode;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}