class News {
  late String nid;
  late String title;
  late String description;
  late String content;
  late String author;
  late String url;
  late String urlToImage;

  News({
    required this.nid,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.url,
    required this.urlToImage,
    });

  News.fromJson(Map<String, dynamic> json) {
    nid = json['id'].toString().isEmpty ? json['id'] : "http://avitech.uet.vnu.edu.vn/wp-content/uploads/2021/03/News.jpg";
    title = json['title'] != null ? json['title'] : "http://avitech.uet.vnu.edu.vn/wp-content/uploads/2021/03/News.jpg";
    description = json['description'] != null ? json['description'] : "http://avitech.uet.vnu.edu.vn/wp-content/uploads/2021/03/News.jpg";;
    url = json['url'] != null ? json['url'] : "http://avitech.uet.vnu.edu.vn/wp-content/uploads/2021/03/News.jpg";
    urlToImage = json['thumb'] != null ? json['thumb'] : "http://avitech.uet.vnu.edu.vn/wp-content/uploads/2021/03/News.jpg";
  }
}
