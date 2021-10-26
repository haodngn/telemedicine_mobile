import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';

class CategoryCard extends StatelessWidget {
  var _title;
  var _imageUrl;
  var _bgColor;
  var click;

  CategoryCard(this._title, this._imageUrl, this._bgColor, this.click);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (click == 1)
          {Get.to(ListDoctorScreen())}
        else if (click == 2)
          {Get.to(PatientHistoryScreen())}
        else
          {}
      },
      child: Container(
        width: 130,
        height: 160,
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 110,
                height: 137,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    _title,
                    style: TextStyle(
                      color: kTitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Positioned(
                right: 0,
                child: Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    _imageUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
