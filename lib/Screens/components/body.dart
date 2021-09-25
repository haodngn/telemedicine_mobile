import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telemedicine_mobile/Screens/components/background.dart';
import 'package:telemedicine_mobile/components/google_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          "assets/icons/covid-19.svg",
          height: size.height * 0.5,
        ),
        GoogleButton(),
        // FacebookButton(),
      ],
    ));
  }
}
