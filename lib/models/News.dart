class News {
  late int nid;
  late String title;
  late String description;
  late String content;
  late String author;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late int status;

  News({
    required this.nid,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.status});

  News.fromJson(Map<String, dynamic> json) {
    nid = json['nid'];
    content = json['content'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    status = json['status'];
  }
}
