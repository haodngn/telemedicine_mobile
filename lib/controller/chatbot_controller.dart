import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Chatbot.dart';
import 'package:telemedicine_mobile/models/Message.dart';
import 'package:telemedicine_mobile/models/SymptomHealthCheckPost.dart';

class ChatBotController extends GetxController {
  RxInt indexQuestion = 0.obs;
  var listMessage = [].obs;

  List<Chatbot> listChatbot = [
    new Chatbot(
      question: "Chiều cao của bạn là bao nhiêu?",
      listAnswer: [],
      typeInput: TextInputType.number,
    ),
    new Chatbot(
      question: "Cân nặng của bạn là bao nhiêu?",
      listAnswer: [],
      typeInput: TextInputType.number,
    ),
    new Chatbot(
      question: "Có bị dị ứng gì không?",
      listAnswer: [],
      typeInput: TextInputType.text,
    ),
    new Chatbot(
      question: "Triệu chứng gặp phải là gì?",
      listAnswer: [
        "Ho",
      ],
      typeInput: TextInputType.text,
    ),
    new Chatbot(
      question: "Nhóm máu của bạn là gì?",
      listAnswer: [
        "Nhóm máu A",
        "Nhóm máu B",
        "Nhóm máu AB",
        "Nhóm máu O",
        "Khác",
      ],
      typeInput: TextInputType.text,
    ),
  ];

  RxBool isSend = true.obs;

  void nextQuestion() {
    new Future.delayed(const Duration(seconds: 2),
        () => {if (indexQuestion < listChatbot.length - 1) indexQuestion++});
    if (indexQuestion.value == listChatbot.length - 1) {
      Future.delayed(const Duration(seconds: 2));
    }
  }

  void addListMessage(String messageBot, String messagePatient) {
    listMessage.insert(
        0, Message(messageBot: messageBot, messagePatient: messagePatient));
  }

  void sendMessage() {
    new Future.delayed(const Duration(seconds: 2), () => isSend.value = false);
  }

  void sendMessageSuccess() {
    isSend.value = true;
  }

  RxBool start = false.obs;
  startChatBot() {
    new Future.delayed(const Duration(seconds: 4), () => start.value = true);
  }

  RxBool startBubble = false.obs;
  bubbleAppear() {
    new Future.delayed(
        const Duration(seconds: 2), () => startBubble.value = true);
  }

  RxBool delayTks = false.obs;
  delayThank() {
    new Future.delayed(const Duration(seconds: 2), () {
      delayTks.value = true;
      new Future.delayed(const Duration(seconds: 2), () {
        Get.back();
        Get.back();
      });
    });
  }

  static List listNull = [].obs;
  RxList<dynamic> listResultSymptom = [].obs;
  RxList<dynamic> listSymptom = [].obs;
  RxList<MultiSelectItem<dynamic>> listSymptomItem =
      listNull.map((e) => MultiSelectItem(e, e.toString())).toList().obs;

  getListSymptom() {
    FetchAPI.fetchContentSymptom().then((dataFromServer) {
      listSymptom.value = dataFromServer;
    });

    new Future.delayed(
        const Duration(seconds: 2),
        () => {
              listSymptomItem.value = listSymptom
                  .map((symptom) => MultiSelectItem(symptom, symptom.name))
                  .toList()
            });
  }

  RxBool multiSelect = true.obs;
  RxString ansMultiSelect = "".obs;
  RxList listSymptomHealthCheckPost = [].obs;
  multiSelectDone() {
    listSymptomHealthCheckPost.clear();
    multiSelect.value = false;
    listResultSymptom.map((element) {
      ansMultiSelect.value += element.name + ", ";
      listSymptomHealthCheckPost.add(new SymptomHealthCheckPost(
          symptomId: element.id, evidence: "string"));
    }).toList();

    ansMultiSelect.value = ansMultiSelect.toString().replaceRange(
        ansMultiSelect.toString().lastIndexOf(", "),
        ansMultiSelect.toString().lastIndexOf(", ") + 1,
        "");
  }
}
