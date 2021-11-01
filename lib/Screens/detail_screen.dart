import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/book_consultation.dart';
import 'package:telemedicine_mobile/Screens/components/schedule.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class DetailScreen extends StatelessWidget {
  var _name;
  var _scopeOfPractice;
  var _description;
  var _imageUrl;
  var majorDoctors;
  var hospitalDoctors;
  var certificationDoctors;
  var rating;
  var numberOfConsultants;
  var dateOfCertificate;

  DetailScreen(
    this._name,
    this._scopeOfPractice,
    this._description,
    this._imageUrl,
    this.majorDoctors,
    this.hospitalDoctors,
    this.certificationDoctors,
    this.rating,
    this.numberOfConsultants,
    this.dateOfCertificate,
  );

  final listDoctorController = Get.put(ListDoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Bs. " + _name,
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
                                            color: kTitleTextColor
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        child: RatingBar.builder(
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                          initialRating: rating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          unratedColor:
                                              Colors.amber.withAlpha(50),
                                          itemSize: 22.0,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  color: Color(0xfff0f0f0),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Bệnh nhân",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(numberOfConsultants.toString() + "+",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  color: Color(0xfff0f0f0),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Kinh nghiệm",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          (DateTime.now()
                                                          .difference(
                                                              DateTime.parse(
                                                                  dateOfCertificate))
                                                          .inDays ~/
                                                      365)
                                                  .toString() +
                                              " năm",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  color: Color(0xfff0f0f0),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Đánh giá",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(rating.toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
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
                                          return certificationD
                                              .certification.name;
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
                                    itemCount:
                                        listDoctorController.listSlot.length,
                                    itemBuilder: (BuildContext context, index) {
                                      if (listDoctorController
                                              .listSlot[index].healthCheckID <
                                          1) {
                                        listDoctorController
                                            .slotAvailable.value = true;
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ScheduleCard(
                                          'Buổi tư vấn',
                                          DateFormat.EEEE(Locale("vi", "VN").languageCode).format(
                                                    DateTime.parse(
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
                                          DateFormat('dd').format(
                                              DateTime.parse(
                                                  listDoctorController
                                                      .listSlot[index]
                                                      .assignedDate)),
                                          DateFormat('MMM').format(
                                              DateTime.parse(
                                                  listDoctorController
                                                      .listSlot[index]
                                                      .assignedDate)),
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
                                          false,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => {
                      if (listDoctorController.slotAvailable.value)
                        {
                          Get.to(BookConsultationScreen()),
                        }
                      else
                        {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Thông báo"),
                                  content: Text("Bác sĩ chưa có lịch tư vấn"),
                                  actions: [
                                    OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text("Đóng"),)
                                  ],
                                );
                              })
                        }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: kBlueColor,
                      ),
                      child: Center(
                        child: Text(
                          "Đặt lịch tư vấn",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
