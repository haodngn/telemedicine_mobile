import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/covid_screen.dart';
import 'package:telemedicine_mobile/Screens/hospial_map/hospital_map.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';

class CategoryCard extends StatelessWidget {
  var _title;
  var _imageUrl;
  var _bgColor;
  var click;

  CategoryCard(this._title, this._imageUrl, this._bgColor, this.click);
  final bottomNavbarController = Get.put(BottomNavbarController());
  final filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (click == 1)
          {
            filterController.getListMajor(),
            bottomNavbarController.currentIndex.value = 1,
          }
        else if (click == 2)
          {
            bottomNavbarController.currentIndex.value = 2,
          }
        else if (click == 4)
          {Get.to(HospitalMap())}
        else if (click == 5)
          {Get.to(Covid19())}
      },
      child: Container(
        width: 130,
        height: 160,
        child: Stack(
          children: [
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
          ],
        ),
      ),
    );
  }
}
