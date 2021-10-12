import 'package:expandable_text/expandable_text.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/components/schedule.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  var _name;
  var _scopeOfPractice;
  var _description;
  var _imageUrl;
  var majorDoctors;
  var hospitalDoctors;
  var certificationDoctors;

  DetailScreen(
    this._name,
    this._scopeOfPractice,
    this._description,
    this._imageUrl,
    this.majorDoctors,
    this.hospitalDoctors,
    this.certificationDoctors,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/3dots.svg',
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(
                            _imageUrl,
                            errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/default_avatar.png",height: 120, width: 112),
                            height: 120,
                            width: 112,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kTitleTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  _scopeOfPractice,
                                  style: TextStyle(
                                    color: kTitleTextColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/phone.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/chat.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kOrangeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/video.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Thông tin bác sĩ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ExpandableText(
                          "Công tác tại: " +
                              hospitalDoctors
                                  .map((hospitalD) {
                                    return hospitalD.hospital.name;
                                  })
                                  .toList()
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "") +
                              "\nChuyên ngành: " +
                              majorDoctors
                                  .map((majorD) {
                                    return majorD.major.name;
                                  })
                                  .toList()
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "") +
                              "\nChứng chỉ: " +
                              certificationDoctors
                                  .map((certificationD) {
                                    return certificationD.certification.name;
                                  })
                                  .toList()
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "") + "\nMô tả: " + certificationDoctors
                              .map((certificationD) {
                            return certificationD.certification.description;
                          })
                              .toList()
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""),// + _description==null || _description.isEmpty ? "" : _description,
                          style: TextStyle(
                            height: 1.6,
                            color: kTitleTextColor.withOpacity(0.7),
                            fontSize: 16,
                          ),
                          maxLines: 6,
                          collapseText: "Show less",
                          expandText: "Show more",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Upcoming Schedules',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '12',
                        'Jan',
                        kBlueColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '13',
                        'Jan',
                        kYellowColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '14',
                        'Jan',
                        kOrangeColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
