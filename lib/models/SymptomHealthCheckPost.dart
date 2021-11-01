class SymptomHealthCheckPost {
  late int symptomId;
  late String evidence;

  SymptomHealthCheckPost({
    required this.symptomId,
    required this.evidence,
  });

  SymptomHealthCheckPost.fromJson(Map<String, dynamic> json) {
    symptomId = json['symptomId'];
    evidence = json['evidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptomId'] = this.symptomId;
    data['evidence'] = this.evidence;
    return data;
  }
}
