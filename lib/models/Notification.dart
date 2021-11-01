class NotificationPatient {
  late int id;
  late String content;
  late int userId;
  late String createdDate;
  late bool isSeen;
  late bool isActive;
  late int type;
  late String user;

  NotificationPatient(
      {required this.id,
      required this.content,
      required this.userId,
      required this.createdDate,
      required this.isSeen,
      required this.isActive,
      required this.type,
      required this.user});

  NotificationPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    userId = json['userId'];
    createdDate = json['createdDate'];
    isSeen = json['isSeen'];
    isActive = json['isActive'];
    type = json['type'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['userId'] = this.userId;
    data['createdDate'] = this.createdDate;
    data['isSeen'] = this.isSeen;
    data['isActive'] = this.isActive;
    data['type'] = this.type;
    data['user'] = this.user;
    return data;
  }
}
