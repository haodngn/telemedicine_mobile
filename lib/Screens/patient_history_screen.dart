import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientHistoryScreenState createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  final patientHistoryController = Get.put(PatientHistoryController());

  @override
  void initState() {
    super.initState();
    patientHistoryController.getMyHistory();
    patientHistoryController.sttHistory.value = "upcoming";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text("Lịch khám"),
        centerTitle: true,
        backgroundColor: kBlueColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfff6f6f6),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => {
                            patientHistoryController.sttHistory.value =
                                "upcoming"
                          },
                          child: Container(
                            width: 104,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  patientHistoryController.sttHistory.value ==
                                          "upcoming"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                            ),
                            child: Center(
                                child: Text(
                              "Sắp tới",
                              style: TextStyle(
                                color:
                                    patientHistoryController.sttHistory.value ==
                                            "upcoming"
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () => {
                            patientHistoryController.sttHistory.value =
                                "complete"
                          },
                          child: Container(
                            width: 104,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  patientHistoryController.sttHistory.value ==
                                          "complete"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                            ),
                            child: Center(
                                child: Text(
                              "Hoàn thành",
                              style: TextStyle(
                                color:
                                    patientHistoryController.sttHistory.value ==
                                            "complete"
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () => {
                            patientHistoryController.sttHistory.value = "cancel"
                          },
                          child: Container(
                            width: 104,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  patientHistoryController.sttHistory.value ==
                                          "cancel"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                            ),
                            child: Center(
                                child: Text(
                              "Đã hủy",
                              style: TextStyle(
                                color:
                                    patientHistoryController.sttHistory.value ==
                                            "cancel"
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          patientHistoryController.listHealthCheck.length,
                      itemBuilder: (BuildContext context, index) {
                        return patientHistoryController
                                        .listHealthCheck[index].status ==
                                    "BOOKED" &&
                                patientHistoryController.sttHistory.value ==
                                    "upcoming"
                            ? BoxHistory(
                                doctorImage: patientHistoryController
                                    .listHealthCheck[index]
                                    .slots[0]
                                    .doctor
                                    .avatar,
                                doctorName: patientHistoryController
                                    .listHealthCheck[index]
                                    .slots[0]
                                    .doctor
                                    .name,
                                date: DateFormat('EEE').format(DateTime.parse(
                                        patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .assignedDate)) +
                                    ", " +
                                    DateFormat('dd').format(DateTime.parse(
                                        patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .assignedDate)) +
                                    " tháng" +
                                    DateFormat('MM').format(DateTime.parse(
                                        patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .assignedDate)),
                                timeStart: patientHistoryController
                                    .listHealthCheck[index].slots[0].startTime
                                    .toString()
                                    .replaceRange(5, 8, ""),
                                timeEnd: patientHistoryController
                                    .listHealthCheck[index].slots[0].endTime
                                    .toString()
                                    .replaceRange(5, 8, ""),
                                index: index,
                              )
                            : patientHistoryController
                                            .listHealthCheck[index].status ==
                                        "COMPLETED" &&
                                    patientHistoryController.sttHistory.value ==
                                        "complete"
                                ? BoxHistoryPast(
                                    doctorImage: patientHistoryController
                                        .listHealthCheck[index]
                                        .slots[0]
                                        .doctor
                                        .avatar,
                                    doctorName: patientHistoryController
                                        .listHealthCheck[index]
                                        .slots[0]
                                        .doctor
                                        .name,
                                    date: DateFormat('EEE').format(
                                            DateTime.parse(
                                                patientHistoryController
                                                    .listHealthCheck[index]
                                                    .slots[0]
                                                    .assignedDate)) +
                                        ", " +
                                        DateFormat('dd').format(DateTime.parse(
                                            patientHistoryController
                                                .listHealthCheck[index]
                                                .slots[0]
                                                .assignedDate)) +
                                        " tháng" +
                                        DateFormat('MM').format(DateTime.parse(
                                            patientHistoryController
                                                .listHealthCheck[index]
                                                .slots[0]
                                                .assignedDate)),
                                    timeStart: patientHistoryController
                                        .listHealthCheck[index]
                                        .slots[0]
                                        .startTime
                                        .toString()
                                        .replaceRange(5, 8, ""),
                                    timeEnd: patientHistoryController
                                        .listHealthCheck[index].slots[0].endTime
                                        .toString()
                                        .replaceRange(5, 8, ""),
                                    index: index,
                                  )
                                : patientHistoryController
                                                .listHealthCheck[index]
                                                .status ==
                                            "CANCELED" &&
                                        patientHistoryController
                                                .sttHistory.value ==
                                            "cancel"
                                    ? BoxHistoryPast(
                                        doctorImage: patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .doctor
                                            .avatar,
                                        doctorName: patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .doctor
                                            .name,
                                        date: DateFormat('EEE').format(
                                                DateTime.parse(
                                                    patientHistoryController
                                                        .listHealthCheck[index]
                                                        .slots[0]
                                                        .assignedDate)) +
                                            ", " +
                                            DateFormat('dd').format(DateTime.parse(
                                                patientHistoryController
                                                    .listHealthCheck[index]
                                                    .slots[0]
                                                    .assignedDate)) +
                                            " tháng" +
                                            DateFormat('MM').format(DateTime.parse(
                                                patientHistoryController
                                                    .listHealthCheck[index]
                                                    .slots[0]
                                                    .assignedDate)),
                                        timeStart: patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .startTime
                                            .toString()
                                            .replaceRange(5, 8, ""),
                                        timeEnd: patientHistoryController
                                            .listHealthCheck[index]
                                            .slots[0]
                                            .endTime
                                            .toString()
                                            .replaceRange(5, 8, ""),
                                        index: index,
                                      )
                                    : Container();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoxHistory extends StatelessWidget {
  final patientHistoryController = Get.put(PatientHistoryController());

  final String doctorImage;
  final String doctorName;
  final String date;
  final String timeStart;
  final String timeEnd;
  final int index;

  BoxHistory({
    required this.doctorImage,
    required this.doctorName,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(doctorImage,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/default_avatar.png",
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Text(
                doctorName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
              child: Text(
                "Chuyên khoa",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
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
                  color: Color(0xffededed),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        date,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        timeStart + " - " + timeEnd,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Row(
                children: [
                  Container(
                    width: 140,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(width: 1),
                      color: kWhiteColor,
                    ),
                    child: Center(
                      child: Text(
                        "Hủy",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => {
                      patientHistoryController.index.value = index,
                      Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Color(0xff85a7fa),
                      ),
                      child: Center(
                        child: Text(
                          "Chi tiết",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
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

class BoxHistoryPast extends StatelessWidget {
  final patientHistoryController = Get.put(PatientHistoryController());

  final String doctorImage;
  final String doctorName;
  final String date;
  final String timeStart;
  final String timeEnd;
  final int index;

  BoxHistoryPast({
    required this.doctorImage,
    required this.doctorName,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 5,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(7, 8)),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(doctorImage,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/images/default_avatar.png",
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Text(
                    doctorName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
                  child: Text(
                    "Chuyên khoa",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
                      color: Color(0xffededed),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            date,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            timeStart + " - " + timeEnd,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: InkWell(
                    onTap: () => {
                      patientHistoryController.index.value = index,
                      Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Color(0xff85a7fa),
                      ),
                      child: Center(
                        child: Text(
                          "Chi tiết",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
