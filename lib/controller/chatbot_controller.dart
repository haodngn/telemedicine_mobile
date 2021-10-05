import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/models/Chatbot.dart';
import 'package:telemedicine_mobile/models/Message.dart';

class ChatBotController extends GetxController {
  var indexQuestion = 0.obs;
  var listMessage = [].obs;
  List<Chatbot> listChatbot = [
    new Chatbot(
      question: "Chào bạn. Chiều cao của bạn là bao nhiêu?",
      listAnswer: [],
      typeInput: TextInputType.number,
    ),
    new Chatbot(
      question: "Cân nặng của bạn là bao nhiêu??",
      listAnswer: [],
      typeInput: TextInputType.number,
    ),
    new Chatbot(
      question: "Có bị dị ứng gì không?",
      listAnswer: [],
      typeInput: TextInputType.text,
    ),
    new Chatbot(
      question: "Nhóm máu của bạn là gì",
      listAnswer: [
        "Nhóm máu A",
        "Nhóm máu B",
        "Nhóm máu AB",
        "Nhóm máu O",
        "Khác",
      ],
      typeInput: TextInputType.text,
    ),
    new Chatbot(
      question: "Triệu chứng gặp phải là gì?",
      listAnswer: [
        "Ho",
        "Sổ mũi",
        "Đau đầu",
        "Khác",
      ],
      typeInput: TextInputType.text,
    ),
    new Chatbot(
        question: "Câu hỏi khác?",
        listAnswer: [
          "AAAAAAAAAAAAAA",
          "BBBBBBBBBBBBBB",
        ],
        typeInput: TextInputType.text,
    ),
  ];

  var isSend = true.obs;

  void nextQuestion() {
    new Future.delayed(const Duration(seconds: 2),
        () => {if (indexQuestion < listChatbot.length - 1) indexQuestion++});
    if(indexQuestion.value == listChatbot.length - 1) {
      Future.delayed(const Duration(seconds: 2));
    }
  }

  void addListMessage(String messageBot, String messagePatient) {
    listMessage.insert(
        0, Message(messageBot: messageBot, messagePatient: messagePatient));
  }

  void SendMessage() {
    new Future.delayed(const Duration(seconds: 2),
            () => isSend.value = false);
  }

  void SendMessageSuccess() {
    isSend.value = true;
  }
}
