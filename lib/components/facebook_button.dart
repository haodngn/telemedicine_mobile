import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/components/check_login.dart';
import 'package:telemedicine_mobile/controller/facebook_login_controller.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        child: Image.asset(
          "assets/images/facebook.png",
          width: 240,
        ),
        onTap: () {
          Provider.of<FacebookSignInController>(context, listen: false)
              .facebookLogin();
          Navigator.push(
              context, MaterialPageRoute(builder: checkLoginFacebook));
        },
      ),
    );
  }

  Widget checkLoginFacebook(BuildContext context) {
    return CheckLogin();
  }
}
