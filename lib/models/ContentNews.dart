import 'package:telemedicine_mobile/models/News.dart';

class ContentNews {
  late int total;
  late List<News> news = [];

  ContentNews(
      {required this.total,
        required this.news});

  ContentNews.fromJson(Map<String, dynamic> json) {
    if (json['data']['items'] != null) {
      json['data']['items'].forEach((v) {
        v != null ? news.add(new News.fromJson(v)) : "";
      });
    }
  }

}