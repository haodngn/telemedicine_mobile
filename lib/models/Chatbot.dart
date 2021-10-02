class Chatbot {
  late String question;
  late List<String> listAnswer;
  Chatbot({required this.question, required this.listAnswer});
  String get quest => question;
  List<String> get listAns => listAnswer;
}