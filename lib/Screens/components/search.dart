import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';

class SearchBar extends StatelessWidget {
  FilterController filterController = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Tìm kiếm',
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            onPressed: () => {
              Get.to(FilterScreen(),
                  transition: Transition.downToUp,
                  duration: Duration(milliseconds: 600))
            },
            color: kOrangeColor,
            padding: EdgeInsets.symmetric(
              horizontal: 1,
              vertical: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ],
    );
  }
}
