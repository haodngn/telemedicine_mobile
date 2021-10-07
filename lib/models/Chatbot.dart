import 'package:flutter/cupertino.dart';

class Chatbot {
  late String question;
  late List<String> listAnswer;
  late TextInputType typeInput;
  Chatbot({required this.question, required this.listAnswer, required this.typeInput});
  String get quest => question;
  List<String> get listAns => listAnswer;
  TextInputType get tpInput => typeInput;
}