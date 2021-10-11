import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/controller/chatbot_controller.dart';
import 'package:telemedicine_mobile/models/Chatbot.dart';
import 'package:bubble/bubble.dart';
import 'package:telemedicine_mobile/models/Message.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController textSendMessage = TextEditingController();

  final chatbotcontroller = Get.put(ChatBotController());

  @override
  void initState() {
    super.initState();
    if (chatbotcontroller.listChatbot[0].listAnswer.isEmpty) {
      chatbotcontroller.SendMessage();
    }
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
                              Column(
                                  children: chatbotcontroller
                                      .listChatbot[
                                          chatbotcontroller.indexQuestion.value]
                                      .listAnswer
                                      .map(
                                        (ans) => Padding(
                                          padding: const EdgeInsets.fromLTRB(
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
                                                        messagePatient: ans)),
                                                chatbotcontroller
                                                    .nextQuestion(),
                                                chatbotcontroller.accept.value = ans,
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: Text(ans),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ],
                          ),
                        )),
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
                          hintText: "Send your message",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                    )),
                    //SizedBox(width: 50,),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
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
                      chatbotcontroller.indexQuestion.value && chatbotcontroller.accept.value == "Đồng ý"
              ? Bubble(
                  radius: Radius.circular(15.0),
                  color: Colors.grey.shade200,
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 45,
                    height: 30,
                    // padding: EdgeInsets.only(bottom: 0),
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
                      chatbotcontroller.indexQuestion.value && chatbotcontroller.accept.value == "Đồng ý"
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
                    Column(
                        children: chatbot.listAnswer
                            .map(
                              (ans) => Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 0, 100, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    onPressed: () => {
                                      if (chatbotcontroller
                                                  .indexQuestion.value <
                                              chatbotcontroller
                                                      .listChatbot.length -
                                                  1 &&
                                          chatbotcontroller
                                              .listChatbot[chatbotcontroller
                                                      .indexQuestion.value +
                                                  1]
                                              .listAnswer
                                              .isEmpty)
                                        {
                                          chatbotcontroller.SendMessage(),
                                        },
                                      chatbotcontroller.listMessage.insert(
                                          0,
                                          Message(
                                              messageBot: chatbot.question,
                                              messagePatient: ans)),
                                      chatbotcontroller.nextQuestion(),
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
                      chatbotcontroller.indexQuestion.value
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
                              "Cảm ơn bạn.",
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
              : Container()
        ],
      ),
    );
  }
}
