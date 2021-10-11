class TimeFrame {
  late int id;
  late String startTime;
  late String endTime;

  TimeFrame({required this.id, required this.startTime, required this.endTime});

  TimeFrame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}