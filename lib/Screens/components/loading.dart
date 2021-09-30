import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      )),
    );
  }
}
