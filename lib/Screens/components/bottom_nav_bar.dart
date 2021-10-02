import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
import 'package:telemedicine_mobile/constant.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  final screens = [
    HomeScreen(),
    ListDoctorScreen(),
    PatientProfile(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: SizedBox(
          height: 45,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBackgroundColor,
            selectedItemColor: kBlueColor,
            showUnselectedLabels: false,
            iconSize: 25,
            selectedFontSize: 8,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: "Doctor List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      );
}