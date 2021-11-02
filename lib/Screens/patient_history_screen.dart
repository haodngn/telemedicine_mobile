import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/chatbot_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientHistoryScreenState createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  final patientHistoryController = Get.put(PatientHistoryController());
  final listDoctorController = Get.put(ListDoctorController());

  @override
  void initState() {
    super.initState();
    listDoctorController.getAllDoctor();
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
                  padding: const EdgeInsets.fromLTRB(27, 20, 27, 20),
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
                        Expanded(
                          child: InkWell(
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
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "upcoming"
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
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
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "complete"
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => {
                              patientHistoryController.sttHistory.value =
                                  "cancel"
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
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "cancel"
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              )),
                            ),
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
                                date: patientHistoryController
                                    .listHealthCheck[index]
                                    .slots[0]
                                    .assignedDate,
                                timeStart: patientHistoryController
                                    .listHealthCheck[index].slots[0].startTime,
                                timeEnd: patientHistoryController
                                    .listHealthCheck[index].slots[0].endTime,
                                index: index,
                                healthCheckID: patientHistoryController
                                    .listHealthCheck[index].id)
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
                                    date: DateFormat.E(Locale("vi", "VN").languageCode)
                                            .format(DateTime.parse(
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
                                            patientHistoryController.listHealthCheck[index].slots[0].assignedDate)),
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
                                    comment: patientHistoryController
                                                .listHealthCheck[index]
                                                .comment ==
                                            null
                                        ? TextEditingController()
                                        : TextEditingController(
                                            text: patientHistoryController
                                                .listHealthCheck[index]
                                                .comment),
                                    rating: patientHistoryController
                                                .listHealthCheck[index]
                                                .rating ==
                                            null
                                        ? 0
                                        : patientHistoryController
                                            .listHealthCheck[index].rating,
                                    healthCheck: patientHistoryController
                                        .listHealthCheck[index],
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
                                        date: DateFormat.E(Locale("vi", "VN").languageCode)
                                                .format(DateTime.parse(
                                                    patientHistoryController
                                                        .listHealthCheck[index]
                                                        .slots[0]
                                                        .assignedDate)) +
                                            ", " +
                                            DateFormat('dd').format(
                                                DateTime.parse(
                                                    patientHistoryController
                                                        .listHealthCheck[index]
                                                        .slots[0]
                                                        .assignedDate)) +
                                            " tháng" +
                                            DateFormat('MM').format(DateTime.parse(
                                                patientHistoryController.listHealthCheck[index].slots[0].assignedDate)),
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
                                        comment: TextEditingController(),
                                        rating: 0,
                                        healthCheck: patientHistoryController
                                            .listHealthCheck[index],
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
  final chatbotcontroller = Get.put(ChatBotController());
  final listDoctorController = Get.put(ListDoctorController());
  TextEditingController reason = TextEditingController();

  final String doctorImage;
  final String doctorName;
  final String date;
  final String timeStart;
  final String timeEnd;
  final int index;
  final int healthCheckID;

  BoxHistory({
    required this.doctorImage,
    required this.doctorName,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.index,
    required this.healthCheckID,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(27, 15, 27, 15),
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kBlueLightColor.withOpacity(0.6),
        ),
        child: Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(doctorImage,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          "assets/images/default_avatar.png",
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Text(
                "Bs." + doctorName,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kTitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
              child: Text(
                "Chuyên khoa",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kTitleTextColor.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(242, 0, 0, 0),
              child: InkWell(
                onTap: () => {
                  if (DateTime.now().compareTo(DateTime.parse(
                          DateFormat("yyyy-MM-dd")
                                  .format(DateTime.parse(date)) +
                              " " +
                              timeStart)) ==
                      1)
                    {
                      listDoctorController.getTokenHealthCheck(healthCheckID),
                    }
                  else
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Thông báo"),
                              content: Text("Chưa tới giờ tư vấn"),
                              actions: [
                                OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
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
                  color: kBlueColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 14),
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
                        DateFormat.E(Locale("vi", "VN").languageCode)
                                .format(DateTime.parse(date)) +
                            ", " +
                            DateFormat('dd').format(DateTime.parse(date)) +
                            " tháng" +
                            DateFormat('MM').format(DateTime.parse(date)),
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
                        timeStart.toString().replaceRange(5, 8, "") +
                            " - " +
                            timeEnd.toString().replaceRange(5, 8, ""),
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
              padding: const EdgeInsets.only(top: 130.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => {
                      patientHistoryController.emptyReason.value = false,
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Thông báo"),
                              content: Text("Bạn có muốn hủy lịch hẹn này?"),
                              actions: [
                                MaterialButton(
                                  elevation: 5,
                                  child: Text("Không"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                MaterialButton(
                                  elevation: 5,
                                  child: Text("Có"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Lý do?"),
                                            content: Obx(
                                              () => TextField(
                                                controller: reason,
                                                decoration: InputDecoration(
                                                  errorText:
                                                      patientHistoryController
                                                              .emptyReason.value
                                                          ? "Vui lòng nhập lý do hủy lịch hẹn"
                                                          : null,
                                                  errorStyle:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              MaterialButton(
                                                elevation: 5,
                                                child: Text("Gửi"),
                                                onPressed: () {
                                                  if (reason.text.isEmpty) {
                                                    patientHistoryController
                                                        .emptyReason
                                                        .value = true;
                                                  } else {
                                                    patientHistoryController
                                                        .cancelHealthCheck(
                                                            healthCheckID,
                                                            reason.text);
                                                    Navigator.of(context).pop();
                                                    Fluttertoast.showToast(
                                                        msg: "Đã hủy cuộc hẹn",
                                                        fontSize: 18);
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ],
                            );
                          }),
                    },
                    child: Container(
                      width: 130,
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
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => {
                      chatbotcontroller.getListSymptom(),
                      patientHistoryController.index.value = index,
                      Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
                    },
                    child: Container(
                      width: 130,
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
  final TextEditingController comment;
  late int rating;
  final HealthCheck healthCheck;

  BoxHistoryPast({
    required this.doctorImage,
    required this.doctorName,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.index,
    required this.comment,
    required this.rating,
    required this.healthCheck,
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
          color: kBlueLightColor.withOpacity(0.6),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image.network(
                      doctorImage,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/default_avatar.png",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Text(
                    "Bs. " + doctorName,
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
                  padding: const EdgeInsets.only(top: 64),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  padding: const EdgeInsets.only(top: 130.0),
                  child: patientHistoryController.sttHistory.value == "complete"
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                patientHistoryController.emptyComment.value =
                                    false;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Center(child: Text("Đánh giá")),
                                        content: Container(
                                          height: 180,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Bình luận",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              Obx(
                                                () => TextField(
                                                  controller: comment,
                                                  decoration: InputDecoration(
                                                    errorText:
                                                        patientHistoryController
                                                                .emptyComment
                                                                .value
                                                            ? "Vui lòng nhập bình luận"
                                                            : null,
                                                    errorStyle:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Center(
                                                child: Container(
                                                  height: 50,
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 8),
                                                  child: RatingBar.builder(
                                                    onRatingUpdate:
                                                        (ratingValue) {
                                                      rating =
                                                          ratingValue.round();
                                                    },
                                                    initialRating: rating + 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    unratedColor: Colors.amber
                                                        .withAlpha(50),
                                                    itemSize: 30.0,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            elevation: 5,
                                            child: Text("Gửi"),
                                            onPressed: () {
                                              if (comment.text.isEmpty) {
                                                patientHistoryController
                                                    .emptyComment.value = true;
                                              } else {
                                                patientHistoryController
                                                    .editHealthCheckInfo(
                                                        rating,
                                                        comment.text,
                                                        healthCheck,
                                                        0,
                                                        0);
                                                Navigator.of(context).pop();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Đánh giá của bạn đã được gửi",
                                                    fontSize: 18);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: 130,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(width: 1),
                                  color: kWhiteColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Đánh giá",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
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
                                width: 130,
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
                        )
                      : InkWell(
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
