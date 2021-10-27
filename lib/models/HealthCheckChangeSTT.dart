class HealthCheckChangeSTT {
  late int id;
  late String reasonCancel;
  late String status;

  HealthCheckChangeSTT(
      {required this.id, required this.reasonCancel, required this.status});

  HealthCheckChangeSTT.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reasonCancel = json['reasonCancel'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reasonCancel'] = this.reasonCancel;
    data['status'] = this.status;
    return data;
  }
}
