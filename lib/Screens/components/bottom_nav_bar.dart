import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/Screens/notification_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_history_screen.dart';
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
    PatientHistoryScreen(),
    NotificationScreen(),
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
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: "Danh sách bác sĩ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Lịch sử",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "Thông báo",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Trang cá nhân",
              ),
            ],
          ),
        ),
      );
}