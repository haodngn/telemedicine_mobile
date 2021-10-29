import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/category.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/Screens/notification_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final patientProfileController = Get.put(PatientProfileController());
  final listDoctorController = Get.put(ListDoctorController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final patientHistoryController = Get.put(PatientHistoryController());
  final bottomNavbarController = Get.put(BottomNavbarController());

  Future<bool> getDoctorData({bool isRefresh = false}) async {
    if (!isRefresh) {
      if (listDoctorController.currentPage.value >=
          listDoctorController.totalPage.value) {
        refreshController.loadNoData();
        return true;
      } else {
        listDoctorController.currentPage.value += 1;
      }
    }
    bool isSuccess =
        await listDoctorController.getListDoctor(isRefresh: isRefresh);
    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBlueColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {
              Get.to(NotificationScreen());
            },
          )
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Xin chào ' + patientProfileController.patient.value.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: kTitleTextColor,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Container(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () => {
                          bottomNavbarController.currentIndex.value = 1,
                        },
                        child: Row(children: [
                          Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Tìm kiếm bác sĩ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildCategoryList(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        'Cuộc hẹn sắp tới',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTitleTextColor,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () =>
                            {bottomNavbarController.currentIndex.value = 2},
                        child: Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: kBlueColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                patientProfileController.nearestHealthCheck.value.id == 0
                    ? Center(
                        child: Text(
                        "Bạn chưa có lịch hẹn",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ))
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: InkWell(
                          onTap: () => {
                            patientHistoryController.index.value = 0,
                            Get.to(() => PatientDetailHistoryScreen(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(microseconds: 600)),
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kBlueColor,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    patientProfileController.nearestHealthCheck
                                        .value.slots[0].doctor.avatar,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            "assets/images/default_avatar.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80),
                                  child: Text(
                                    "Bs. " +
                                        patientProfileController
                                            .nearestHealthCheck
                                            .value
                                            .slots[0]
                                            .doctor
                                            .name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 30, 0, 0),
                                  child: Text(
                                    "Chuyên khoa",
                                    style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(250, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () => {
                                      // DateTime.now().compareTo(DateTime
                                      //         .parse(DateFormat("yyyy-MM-dd")
                                      //                 .format(DateTime.parse(
                                      //                     patientProfileController
                                      //                         .nearestHealthCheck
                                      //                         .value
                                      //                         .slots[0]
                                      //                         .assignedDate)) +
                                      //             " " +
                                      //             patientProfileController
                                      //                 .nearestHealthCheck
                                      //                 .value
                                      //                 .slots[0]
                                      //                 .startTime)) ==
                                      //     1
                                      if (true)
                                        {
                                          listDoctorController
                                              .getTokenHealthCheck(
                                                  patientProfileController
                                                      .nearestHealthCheck
                                                      .value
                                                      .id),
                                        }
                                      else
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Thông báo"),
                                                  content: Text(
                                                      "Chưa tới giờ tư vấn"),
                                                  actions: [
                                                    OutlineButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Text("Đóng"),
                                                    )
                                                  ],
                                                );
                                              })
                                        }
                                    },
                                    child: Icon(
                                      Icons.phone,
                                      size: 40,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff85a7fa),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            DateFormat.E(Locale("vi", "VN").languageCode).format(
                                                    DateTime.parse(patientProfileController
                                                        .nearestHealthCheck
                                                        .value
                                                        .slots[0]
                                                        .assignedDate)) +
                                                ", " +
                                                DateFormat('dd').format(DateTime.parse(
                                                    patientProfileController
                                                        .nearestHealthCheck
                                                        .value
                                                        .slots[0]
                                                        .assignedDate)) +
                                                " tháng" +
                                                DateFormat('MM').format(DateTime.parse(
                                                    patientProfileController
                                                        .nearestHealthCheck
                                                        .value
                                                        .slots[0]
                                                        .assignedDate)),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            patientProfileController
                                                    .nearestHealthCheck
                                                    .value
                                                    .slots[0]
                                                    .startTime
                                                    .toString()
                                                    .replaceRange(5, 8, "") +
                                                " - " +
                                                patientProfileController
                                                    .nearestHealthCheck
                                                    .value
                                                    .slots[0]
                                                    .endTime
                                                    .toString()
                                                    .replaceRange(5, 8, ""),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Bác sĩ hàng đầu',
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
                patientHistoryController.listTopDoctor.length > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: InkWell(
                          onTap: () => {
                            listDoctorController.getListDoctorSlot(
                                patientHistoryController.listTopDoctor[0].id),
                            patientProfileController.getMyPatient(),
                            Get.to(DetailScreen(
                              patientHistoryController.listTopDoctor[0].name,
                              patientHistoryController
                                  .listTopDoctor[0].scopeOfPractice,
                              patientHistoryController
                                  .listTopDoctor[0].description,
                              patientHistoryController.listTopDoctor[0].avatar,
                              patientHistoryController
                                  .listTopDoctor[0].majorDoctors,
                              patientHistoryController
                                  .listTopDoctor[0].hospitalDoctors,
                              patientHistoryController
                                  .listTopDoctor[0].certificationDoctors,
                              patientHistoryController.listTopDoctor[0].rating,
                              patientHistoryController
                                  .listTopDoctor[0].numberOfConsultants,
                              patientHistoryController
                                  .listTopDoctor[0].dateOfCertificate,
                            )),
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 5,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(7, 8)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 90,
                                  child: Image.network(
                                    patientHistoryController
                                        .listTopDoctor[0].avatar,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            "assets/images/default_avatar.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 90),
                                  child: Text(
                                    "Bs. " +
                                        patientHistoryController
                                            .listTopDoctor[0].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 30, 0, 0),
                                  child: Text(
                                    patientHistoryController.listTopDoctor[0]
                                                .majorDoctors.length >
                                            0
                                        ? patientHistoryController
                                            .listTopDoctor[0]
                                            .majorDoctors[0]
                                            .major
                                            .name
                                        : "",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.75),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 60, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                              .listTopDoctor[0].rating
                                              .toString(),
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          ".",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                                  .listTopDoctor[0]
                                                  .numberOfConsultants
                                                  .toString() +
                                              " đánh giá",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                patientHistoryController.listTopDoctor.length > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: InkWell(
                          onTap: () => {
                            listDoctorController.getListDoctorSlot(
                                patientHistoryController.listTopDoctor[1].id),
                            patientProfileController.getMyPatient(),
                            Get.to(DetailScreen(
                              patientHistoryController.listTopDoctor[1].name,
                              patientHistoryController
                                  .listTopDoctor[1].scopeOfPractice,
                              patientHistoryController
                                  .listTopDoctor[1].description,
                              patientHistoryController.listTopDoctor[1].avatar,
                              patientHistoryController
                                  .listTopDoctor[1].majorDoctors,
                              patientHistoryController
                                  .listTopDoctor[1].hospitalDoctors,
                              patientHistoryController
                                  .listTopDoctor[1].certificationDoctors,
                              patientHistoryController.listTopDoctor[1].rating,
                              patientHistoryController
                                  .listTopDoctor[1].numberOfConsultants,
                              patientHistoryController
                                  .listTopDoctor[1].dateOfCertificate,
                            )),
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 5,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(7, 8)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 90,
                                  child: Image.network(
                                    patientHistoryController
                                        .listTopDoctor[1].avatar,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            "assets/images/default_avatar.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 90),
                                  child: Text(
                                    "Bs. " +
                                        patientHistoryController
                                            .listTopDoctor[1].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 30, 0, 0),
                                  child: Text(
                                    patientHistoryController.listTopDoctor[1]
                                                .majorDoctors.length >
                                            0
                                        ? patientHistoryController
                                            .listTopDoctor[1]
                                            .majorDoctors[0]
                                            .major
                                            .name
                                        : "",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.75),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 60, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                              .listTopDoctor[1].rating
                                              .toString(),
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          ".",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                                  .listTopDoctor[1]
                                                  .numberOfConsultants
                                                  .toString() +
                                              " đánh giá",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                patientHistoryController.listTopDoctor.length > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: InkWell(
                          onTap: () => {
                            listDoctorController.getListDoctorSlot(
                                patientHistoryController.listTopDoctor[2].id),
                            patientProfileController.getMyPatient(),
                            Get.to(DetailScreen(
                              patientHistoryController.listTopDoctor[2].name,
                              patientHistoryController
                                  .listTopDoctor[2].scopeOfPractice,
                              patientHistoryController
                                  .listTopDoctor[2].description,
                              patientHistoryController.listTopDoctor[2].avatar,
                              patientHistoryController
                                  .listTopDoctor[2].majorDoctors,
                              patientHistoryController
                                  .listTopDoctor[2].hospitalDoctors,
                              patientHistoryController
                                  .listTopDoctor[2].certificationDoctors,
                              patientHistoryController.listTopDoctor[2].rating,
                              patientHistoryController
                                  .listTopDoctor[2].numberOfConsultants,
                              patientHistoryController
                                  .listTopDoctor[2].dateOfCertificate,
                            )),
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 5,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(7, 8)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 90,
                                  child: Image.network(
                                    patientHistoryController
                                        .listTopDoctor[2].avatar,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            "assets/images/default_avatar.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 90),
                                  child: Text(
                                    "Bs. " +
                                        patientHistoryController
                                            .listTopDoctor[2].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 30, 0, 0),
                                  child: Text(
                                    patientHistoryController.listTopDoctor[2]
                                                .majorDoctors.length >
                                            0
                                        ? patientHistoryController
                                            .listTopDoctor[2]
                                            .majorDoctors[0]
                                            .major
                                            .name
                                        : "",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.75),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 60, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                              .listTopDoctor[2].rating
                                              .toString(),
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          ".",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          patientHistoryController
                                                  .listTopDoctor[0]
                                                  .numberOfConsultants
                                                  .toString() +
                                              " đánh giá",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Bình luận phổ biến',
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
                buildTopComment(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Tin tức',
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
                buildNewsList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Danh sách\nbác sĩ',
            'assets/icons/list_doctor.png',
            kYellowColor,
            1,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Lịch sử\ncủa bạn',
            'assets/icons/history_icon.png',
            kOrangeColor,
            2,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Covid-19\nSymptoms',
            'assets/icons/covid19.png',
            kOrangeColor,
            3,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Teeth\nSymptoms',
            'assets/icons/dental_surgeon.png',
            kBlueColor,
            3,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Heart\nSymptoms',
            'assets/icons/heart_surgeon.png',
            kYellowColor,
            3,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard('Eye\nSymptoms', 'assets/icons/eye_specialist.png',
              kOrangeColor, 3),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  buildNewsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () async {
              final url =
                  "https://covid19.gov.vn/se-ban-hanh-huong-dan-tiem-vaccine-phong-covid-19-cho-tre-em-tu-12-18-tuoi-171211012064538258.htm";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 225,
                    height: 225,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Từ 1-10/10 cả nước đã tiêm được 11 triệu liều vaccine',
                        style: TextStyle(
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  child: Container(
                    height: 200,
                    width: 200,
                    // decoration: BoxDecoration(
                    //   color: kBlueColor,
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Image.network(
                        'https://covid19.qltns.mediacdn.vn/354844073405468672/2021/10/12/base64-16339610675771824683604-1633995716703-16339957168241470550172.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () async {
              final url =
                  "https://covid19.gov.vn/nguoi-benh-khong-phai-chi-tra-xet-nghiem-covid-19-khi-den-kham-va-dieu-tri-tai-co-so-y-te-cong-lap-171211010234733766.htm";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 225,
                    height: 225,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Người bệnh không phải chi trả xét nghiệm COVID-19',
                        style: TextStyle(
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  child: Container(
                    height: 200,
                    width: 200,
                    // decoration: BoxDecoration(
                    //   color: kBlueColor,
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Image.network(
                        'https://covid19.qltns.mediacdn.vn/354844073405468672/2021/10/10/lay-mau-xet-nghiem-lai-xe-1627307782568392624728-1633884443237-1633884443907258278064.jpeg'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  buildTopComment() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://static.tuoitre.vn/tto/i/s1280/2017/08/13/65b5ee46-1-1502592668.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Trần Cảnh",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Người dùng",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://tophinhanhdep.com/wp-content/uploads/2021/03/anh-avatar-girl-xinh-200x300.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Trúc Quỳnh",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Người dùng",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://radiologyhanoi.com/uploads/2021/03/rsz_2150215_nguyen_thi_huong_thsbsnt.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lê Thị Tuyết",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Bác sĩ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://newsmd1fr.keeng.net/tiin/archive/images/2016/09/06/144209_12.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Đặng Hữu Nhân",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Bác sĩ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
