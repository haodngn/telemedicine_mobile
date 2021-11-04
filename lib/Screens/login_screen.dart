import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/components/background.dart';
import 'package:telemedicine_mobile/components/facebook_button.dart';
import 'package:telemedicine_mobile/components/google_button.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final accountController = Get.put(AccountController());
  final storage = new Storage.FlutterSecureStorage();

  @override
  void initState() {
    clearStorage();
    super.initState();
  }

  clearStorage() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/covid-19.svg",
                  height: size.height * 0.5,
                ),
                FacebookButton(),
                SizedBox(
                  height: 20,
                ),
                GoogleButton(),
              ],
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.center,
              child: Obx(() => accountController.isLoading.value
                  ? CircularProgressIndicator(color: kWhiteColor)
                  : Container()),
            )),
          ],
        ),
      ),
    );
  }
}



  // Future<void> _createDynamicLink() async {
    
  // }