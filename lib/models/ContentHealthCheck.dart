import 'package:telemedicine_mobile/models/HealthCheck.dart';

class ContentHealthCheck {
  late int totalCount;
  late int pageSize;
  late int totalPage;
  late int currentPage;
  late int nextPage;
  late int? previousPage;
  late List<HealthCheck> healthCheck = [];

  ContentHealthCheck(
      {required this.totalCount,
      required this.pageSize,
      required this.totalPage,
      required this.currentPage,
      required this.nextPage,
      required this.previousPage,
      required this.healthCheck});

  ContentHealthCheck.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        healthCheck.add(new HealthCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['currentPage'] = this.currentPage;
    data['nextPage'] = this.nextPage;
    data['previousPage'] = this.previousPage;
    if (this.healthCheck != null) {
      data['content'] = this.healthCheck.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
