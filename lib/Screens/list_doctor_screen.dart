import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/components/doctor.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';

class ListDoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOCTOR LIST LIST"),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          Padding(
          padding: const EdgeInsets.fromLTRB(300, 20, 0, 20),
          child: ElevatedButton(
              onPressed: () => {
              Get.to(FilterScreen(), transition:
              Transition.downToUp,
              duration: Duration(milliseconds: 600))

          },
          child: Icon(Icons.search),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Top Doctors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kTitleTextColor,
            fontSize: 18,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      buildDoctorList(),

      ],
    ),)
    ,
    )
    ,
    );
  }

  buildDoctorList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            'Dr. Stella Kane',
            'Heart Surgeon\nFlower Hospitals',
            'assets/images/doctor1.png',
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Joseph Cart',
            'Dental Surgeon\nFlower Hospitals',
            'assets/images/doctor2.png',
            kYellowColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Stephanie',
            'Eye Specialist\nFlower Hospitals',
            'assets/images/doctor3.png',
            kOrangeColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
