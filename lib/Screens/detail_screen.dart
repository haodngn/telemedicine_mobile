import 'package:expandable_text/expandable_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/call_screen/videocall_screen.dart';
import 'package:telemedicine_mobile/Screens/components/schedule.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

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

  final listDoctorController = Get.put(ListDoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
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
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      "assets/images/default_avatar.png",
                                      height: 120,
                                      width: 112),
                              height: 120,
                              width: 112,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/video.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                    .replaceAll("]", "") +
                                "\nMô tả: " +
                                certificationDoctors
                                    .map((certificationD) {
                                      return certificationD
                                          .certification.description;
                                    })
                                    .toList()
                                    .toString()
                                    .replaceAll("[", "")
                                    .replaceAll("]",
                                        ""), // + _description==null || _description.isEmpty ? "" : _description,
                            style: TextStyle(
                              height: 1.6,
                              color: kTitleTextColor.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            maxLines: 6,
                            collapseText: "Thu gọn",
                            expandText: "Hiển thị thêm",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Lịch tư vấn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        listDoctorController.listSlot.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listDoctorController.listSlot.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ScheduleCard(
                                      'Buổi tư vấn',
                                      DateFormat('EEEE').format(DateTime.parse(
                                              listDoctorController
                                                  .listSlot[index]
                                                  .assignedDate)) +
                                          ' . ' +
                                          listDoctorController
                                              .listSlot[index].startTime
                                              .toString()
                                              .replaceRange(5, 8, "") +
                                          " - " +
                                          listDoctorController
                                              .listSlot[index].endTime
                                              .toString()
                                              .replaceRange(5, 8, ""),
                                      DateFormat('dd').format(DateTime.parse(
                                          listDoctorController
                                              .listSlot[index].assignedDate)),
                                      DateFormat('MMM').format(DateTime.parse(
                                          listDoctorController
                                              .listSlot[index].assignedDate)),
                                      index % 3 == 0
                                          ? kOrangeColor
                                          : index % 2 == 0
                                              ? kYellowColor
                                              : kBlueColor,
                                      listDoctorController
                                          .listSlot[index].healthCheckID,
                                      listDoctorController.listSlot[index]
                                          .healthCheck.patient.email,
                                      listDoctorController.listSlot[index],
                                    ),
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    "Bác sĩ chưa có lịch tư vấn",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
