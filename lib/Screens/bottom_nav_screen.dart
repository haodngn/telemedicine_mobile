import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/components/bottom_nav_bar.dart';

class BottomNavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
