import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';

class DynamicLinkScreen extends StatefulWidget {
  const DynamicLinkScreen({Key? key}) : super(key: key);

  @override
  _DynamicLinkScreenState createState() => _DynamicLinkScreenState();
}

class _DynamicLinkScreenState extends State<DynamicLinkScreen> {
  TextEditingController textNameController = TextEditingController();
  final accountController = Get.put(AccountController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MetaCine"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBlueColor,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image(
                  image: NetworkImage(
                      "https://png.pngtree.com/element_our/20190530/ourlarge/pngtree-520-couple-avatar-boy-avatar-little-dinosaur-cartoon-cute-image_1263411.jpg"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  controller: textNameController,
                  decoration: InputDecoration(
                    hintText: "Tên của bạn",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Bắt đầu tham gia")),
            ],
          ),
        ),
    );
  }
}
