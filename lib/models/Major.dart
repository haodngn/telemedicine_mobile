class Major {
  late int id;
  late String name;
  late String? description;

  Major({required this.id, required this.name, required this.description});

  Major.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;

    return data;
  }
}
