import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:telemedicine_mobile/controller/chatbot_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/Chatbot.dart';
import 'package:bubble/bubble.dart';
import 'package:telemedicine_mobile/models/Message.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:telemedicine_mobile/models/SymptomHealthCheckPost.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController textSendMessage = TextEditingController();

  final chatbotcontroller = Get.put(ChatBotController());
  final patientProfileController = Get.put(PatientProfileController());
  final listDoctorController = Get.put(ListDoctorController());

  @override
  void initState() {
    super.initState();
    if (chatbotcontroller.listChatbot[0].listAnswer.isEmpty) {
      chatbotcontroller.SendMessage();
    }
    chatbotcontroller.startChatBot();
    chatbotcontroller.bubbleAppear();
    chatbotcontroller.getListSymptom();
    chatbotcontroller.delayTks.value = false;
    chatbotcontroller.multiSelect.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Bot",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: chatbotcontroller.listMessage.length > 0
                    ? ListView.builder(
                        reverse: true,
                        itemCount: chatbotcontroller.listMessage.length,
                        itemBuilder: (BuildContext context, index) {
                          return BoxChat(
                              messageBot: chatbotcontroller
                                  .listMessage[index].messageBot,
                              messagePatient: chatbotcontroller
                                  .listMessage[index].messagePatient,
                              indexQuestion: index,
                              chatbot: chatbotcontroller.listChatbot[
                                  chatbotcontroller.indexQuestion.value]);
                        })
                    : chatbotcontroller.start.value
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: Bubble(
                                    radius: Radius.circular(15.0),
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              "Chào bạn, bạn vui lòng trả lời các câu hỏi sau để hoàn thành đăng ký?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: Bubble(
                                    radius: Radius.circular(15.0),
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              chatbotcontroller
                                                  .listChatbot[chatbotcontroller
                                                      .indexQuestion.value]
                                                  .question,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                chatbotcontroller
                                                .listChatbot[chatbotcontroller
                                                    .indexQuestion.value]
                                                .listAnswer
                                                .length ==
                                            1 &&
                                        chatbotcontroller.multiSelect.value
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 50, 0),
                                        child: MultiSelectDialogField(
                                          items:
                                              chatbotcontroller.listSymptomItem,
                                          title: Text("Triệu chứng"),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          selectedColor: Colors.blue,
                                          buttonText: Text(
                                            "Chọn triệu chứng",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onConfirm: (results) {
                                            chatbotcontroller.listResultSymptom
                                                .value = results;
                                            chatbotcontroller.multiSelectDone();
                                            if (chatbotcontroller
                                                        .listChatbot.length >
                                                    1 &&
                                                chatbotcontroller.listChatbot[1]
                                                    .listAnswer.isEmpty) {
                                              chatbotcontroller.SendMessage();
                                            }
                                            chatbotcontroller.listMessage.insert(
                                                0,
                                                Message(
                                                    messageBot: chatbotcontroller
                                                        .listChatbot[
                                                            chatbotcontroller
                                                                .indexQuestion
                                                                .value]
                                                        .question,
                                                    messagePatient: chatbotcontroller
                                                                .listResultSymptom
                                                                .length >
                                                            0
                                                        ? chatbotcontroller
                                                            .ansMultiSelect
                                                            .value
                                                        : "Không có triệu chứng"));

                                            chatbotcontroller.nextQuestion();
                                          },
                                        ),
                                      )
                                    : Column(
                                        children: chatbotcontroller
                                            .listChatbot[chatbotcontroller
                                                .indexQuestion.value]
                                            .listAnswer
                                            .map(
                                              (ans) => Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        100, 0, 100, 0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: RaisedButton(
                                                    onPressed: () => {
                                                      if (chatbotcontroller
                                                                  .listChatbot
                                                                  .length >
                                                              1 &&
                                                          chatbotcontroller
                                                              .listChatbot[1]
                                                              .listAnswer
                                                              .isEmpty)
                                                        {
                                                          chatbotcontroller
                                                              .SendMessage()
                                                        },
                                                      chatbotcontroller.listMessage.insert(
                                                          0,
                                                          Message(
                                                              messageBot: chatbotcontroller
                                                                  .listChatbot[
                                                                      chatbotcontroller
                                                                          .indexQuestion
                                                                          .value]
                                                                  .question,
                                                              messagePatient:
                                                                  ans)),
                                                      chatbotcontroller
                                                          .nextQuestion(),
                                                    },
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    child: Text(ans),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList()),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: Bubble(
                                    radius: Radius.circular(15.0),
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              "Chào bạn, bạn vui lòng trả lời các câu hỏi sau để hoàn thành đăng ký?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                chatbotcontroller.startBubble.value
                                    ? Bubble(
                                        radius: Radius.circular(15.0),
                                        color: Colors.grey.shade200,
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: 45,
                                          height: 30,
                                          child: JumpingDotsProgressIndicator(
                                            fontSize: 24.0,
                                            dotSpacing: 3,
                                          ),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
              ),
              Divider(
                height: 10.0,
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                      keyboardType: chatbotcontroller
                          .listChatbot[chatbotcontroller.indexQuestion.value]
                          .typeInput,
                      readOnly: chatbotcontroller.isSend.value,
                      controller: textSendMessage,
                      decoration: InputDecoration.collapsed(
                          hintText: "Gửi tin nhắn",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                    )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 30.0,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if (textSendMessage.text.isEmpty) {
                            } else {
                              chatbotcontroller.listMessage.insert(
                                  0,
                                  Message(
                                      messageBot: chatbotcontroller
                                          .listChatbot[chatbotcontroller
                                              .listMessage.length]
                                          .question,
                                      messagePatient: textSendMessage.text));
                              chatbotcontroller.nextQuestion();
                            }
                            textSendMessage.clear();
                            FocusScope.of(context).unfocus();
                            chatbotcontroller.SendMessageSuccess();
                            if (chatbotcontroller
                                .listChatbot[
                                    chatbotcontroller.listMessage.length]
                                .listAnswer
                                .isEmpty) {
                              chatbotcontroller.SendMessage();
                            }
                            if (chatbotcontroller.listMessage.length ==
                                chatbotcontroller.listChatbot.length) {
                              chatbotcontroller.delayThank();
                              listDoctorController.bookHealthCheck(
                                  int.parse(chatbotcontroller
                                      .listMessage[
                                          chatbotcontroller.listMessage.length -
                                              1]
                                      .messagePatient),
                                  int.parse(chatbotcontroller
                                      .listMessage[
                                          chatbotcontroller.listMessage.length -
                                              2]
                                      .messagePatient),
                                  patientProfileController.patient.value,
                                  listDoctorController.slot.value, chatbotcontroller.listSymptomHealthCheckPost.cast<SymptomHealthCheckPost>());
                            }
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BoxChat extends StatelessWidget {
  BoxChat({
    required this.messageBot,
    required this.messagePatient,
    required this.indexQuestion,
    required this.chatbot,
  });

  final String messageBot, messagePatient;
  final int indexQuestion;
  final Chatbot chatbot;

  final chatbotcontroller = Get.put(ChatBotController());
  final patientProfileController = Get.put(PatientProfileController());
  final listDoctorController = Get.put(ListDoctorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            chatbotcontroller.listMessage.length - 1 == indexQuestion
                ? Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Bubble(
                      radius: Radius.circular(15.0),
                      color: Colors.grey.shade200,
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Chào bạn, bạn vui lòng trả lời các câu hỏi sau để hoàn thành đăng ký?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            chatbotcontroller.listMessage.length - 1 == indexQuestion
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 120),
              child: Bubble(
                radius: Radius.circular(15.0),
                color: Colors.grey.shade200,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          messageBot,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
              child: Bubble(
                radius: Radius.circular(15.0),
                color: Colors.blue,
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          messagePatient,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            indexQuestion < 1 &&
                    chatbotcontroller.listMessage.length >
                        chatbotcontroller.indexQuestion.value &&
                    chatbotcontroller.listChatbot.length - 1 >
                        chatbotcontroller.indexQuestion.value
                ? Bubble(
                    radius: Radius.circular(15.0),
                    color: Colors.grey.shade200,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 45,
                      height: 30,
                      child: JumpingDotsProgressIndicator(
                        fontSize: 24.0,
                        dotSpacing: 3,
                      ),
                    ))
                : Container(),
            indexQuestion < 1 &&
                    chatbotcontroller.listMessage.length <
                        chatbotcontroller.listChatbot.length &&
                    chatbotcontroller.listMessage.length ==
                        chatbotcontroller.indexQuestion.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 120),
                        child: Bubble(
                          radius: Radius.circular(15.0),
                          color: Colors.grey.shade200,
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    chatbot.question,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      chatbot.listAnswer.length == 1 &&
                              chatbotcontroller.multiSelect.value
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: MultiSelectDialogField(
                                items: chatbotcontroller.listSymptomItem,
                                title: Text("Triệu chứng"),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                buttonText: Text(
                                  "Chọn triệu chứng",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onConfirm: (results) {
                                  chatbotcontroller.listResultSymptom.value =
                                      results;
                                  chatbotcontroller.multiSelectDone();
                                  if (chatbotcontroller.indexQuestion.value <
                                          chatbotcontroller.listChatbot.length -
                                              1 &&
                                      chatbotcontroller
                                          .listChatbot[chatbotcontroller
                                                  .indexQuestion.value +
                                              1]
                                          .listAnswer
                                          .isEmpty) {
                                    chatbotcontroller.SendMessage();
                                  }
                                  chatbotcontroller.listMessage.insert(
                                      0,
                                      Message(
                                          messageBot: chatbot.question,
                                          messagePatient: chatbotcontroller
                                                      .listResultSymptom
                                                      .length >
                                                  0
                                              ? chatbotcontroller
                                                  .ansMultiSelect.value
                                              : "Không có triệu chứng"));
                                  chatbotcontroller.nextQuestion();
                                },
                              ),
                            )
                          : Column(
                              children: chatbot.listAnswer
                                  .map(
                                    (ans) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          100, 0, 100, 0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: () => {
                                            if (chatbotcontroller
                                                        .indexQuestion.value <
                                                    chatbotcontroller
                                                            .listChatbot
                                                            .length -
                                                        1 &&
                                                chatbotcontroller
                                                    .listChatbot[
                                                        chatbotcontroller
                                                                .indexQuestion
                                                                .value +
                                                            1]
                                                    .listAnswer
                                                    .isEmpty)
                                              {
                                                chatbotcontroller.SendMessage(),
                                              },
                                            chatbotcontroller.listMessage
                                                .insert(
                                                    0,
                                                    Message(
                                                        messageBot:
                                                            chatbot.question,
                                                        messagePatient: ans)),
                                            chatbotcontroller.nextQuestion(),
                                            if (chatbotcontroller
                                                    .listMessage.length ==
                                                chatbotcontroller
                                                    .listChatbot.length)
                                              {
                                                chatbotcontroller.delayThank(),
                                                listDoctorController.bookHealthCheck(
                                                    int.parse(chatbotcontroller
                                                        .listMessage[
                                                            chatbotcontroller
                                                                    .listMessage
                                                                    .length -
                                                                1]
                                                        .messagePatient),
                                                    int.parse(chatbotcontroller
                                                        .listMessage[
                                                            chatbotcontroller
                                                                    .listMessage
                                                                    .length -
                                                                2]
                                                        .messagePatient),
                                                    patientProfileController
                                                        .patient.value,
                                                    listDoctorController
                                                        .slot.value, chatbotcontroller.listSymptomHealthCheckPost.cast<SymptomHealthCheckPost>()),
                                              },
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Text(ans),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                    ],
                  )
                : Container(),
            indexQuestion < 1 &&
                    chatbotcontroller.listMessage.length ==
                        chatbotcontroller.listChatbot.length &&
                    chatbotcontroller.listChatbot.length - 1 ==
                        chatbotcontroller.indexQuestion.value &&
                    !chatbotcontroller.delayTks.value
                ? Bubble(
                    radius: Radius.circular(15.0),
                    color: Colors.grey.shade200,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 45,
                      height: 30,
                      child: JumpingDotsProgressIndicator(
                        fontSize: 24.0,
                        dotSpacing: 3,
                      ),
                    ))
                : Container(),
            indexQuestion < 1 &&
                    chatbotcontroller.listMessage.length ==
                        chatbotcontroller.listChatbot.length &&
                    chatbotcontroller.listChatbot.length - 1 ==
                        chatbotcontroller.indexQuestion.value &&
                    chatbotcontroller.delayTks.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Bubble(
                      radius: Radius.circular(15.0),
                      color: Colors.grey.shade200,
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Cảm ơn bạn đã trả lời các câu hỏi. Đăng ký tư vấn thành công.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
