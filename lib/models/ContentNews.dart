import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/News.dart';

class ContentNews {
  late int total;
  late List<News> news = [];

  ContentNews(
      {required this.total,
        required this.news});

  ContentNews.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
  }

}