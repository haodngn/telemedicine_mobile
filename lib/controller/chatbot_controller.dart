import 'package:get/get.dart';
import 'package:telemedicine_mobile/models/Chatbot.dart';
import 'package:telemedicine_mobile/models/Message.dart';

class ChatBotController extends GetxController {
  var indexQuestion = 0.obs;
  List<Message> listMessage = [];
  List<Chatbot> listChatbot = [
    new Chatbot(
      question: "Chào bạn. Chiều cao của bạn là bao nhiêu?",
      listAnswer: [],
    ),
    new Chatbot(
      question: "Cân nặng của bạn là bao nhiêu??",
      listAnswer: [],
    ),
    new Chatbot(
      question: "Có bị dị ứng gì không?",
      listAnswer: [],
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
    ),
    new Chatbot(
      question: "Triệu chứng gặp phải là gì?",
      listAnswer: [
        "Ho",
        "Sổ mũi",
        "Đau đầu",
        "Khác"
      ],
    ),
    new Chatbot(
      question: "Câu hỏi khác?",
      listAnswer: [
        "AAAAAAAAAAAAAA",
        "BBBBBBBBBBBBBB",
      ],
    ),
  ];

  bool isSend = true;

  void nextQuestion() {
    if (indexQuestion < listChatbot.length) indexQuestion++;
  }

  void addListMessage(String messageBot, String messagePatient) {
    listMessage.insert(
        0, Message(messageBot: messageBot, messagePatient: messagePatient));
  }

  void SendMessage() {
    isSend = false;
  }

  void SendMessageSuccess() {
    isSend = true;
  }
}
