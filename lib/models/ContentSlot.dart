import 'package:telemedicine_mobile/models/Slot.dart';

class ContentSlot {
  late int totalCount;
  late int pageSize;
  late int totalPage;
  late int currentPage;
  late int nextPage;
  late int? previousPage;
  late List<Slot> slot = [];

  ContentSlot(
      {required this.totalCount,
     required this.pageSize,
     required this.totalPage,
     required this.currentPage,
     required this.nextPage,
     required this.previousPage,
     required this.slot});

  ContentSlot.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        slot.add(new Slot.fromJson(v));
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
    if (this.slot != null) {
      data['content'] = this.slot.map((v) => v.toJson()).toList();
    }
    return data;
  }
}