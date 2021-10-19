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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text("Lịch sử"),
        centerTitle: true,
        backgroundColor: kBlueColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(top: 30),
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          patientHistoryController.listHealthCheck.length,
                      itemBuilder: (BuildContext context, index) {
                        return BoxHistory(
                          doctorImage: patientHistoryController
                              .listHealthCheck[index].slots[0].doctor.avatar,
                          doctorName: patientHistoryController
                              .listHealthCheck[index].slots[0].doctor.name,
                          doctorNote: patientHistoryController
                                      .listHealthCheck[index].status ==
                                  "CANCELED"
                              ? patientHistoryController
                                  .listHealthCheck[index].reasonCancel
                              : patientHistoryController
                                          .listHealthCheck[index].status ==
                                      "COMPLETED"
                                  ? patientHistoryController
                                      .listHealthCheck[index].comment
                                  : "",
                          date: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              patientHistoryController
                                  .listHealthCheck[index].createdTime)),
                          sameDate: index > 0
                              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                  patientHistoryController
                                      .listHealthCheck[index - 1].createdTime))
                              : "",
                          timeStart: patientHistoryController
                              .listHealthCheck[index].slots[0].startTime
                              .toString()
                              .replaceRange(5, 8, ""),
                          timeEnd: patientHistoryController
                              .listHealthCheck[index].slots[0].endTime
                              .toString()
                              .replaceRange(5, 8, ""),
                          status: patientHistoryController
                              .listHealthCheck[index].status,
                          index: index,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoxHistory extends StatelessWidget {
  final String doctorImage;
  final String doctorName;
  final String doctorNote;
  final String date;
  final String sameDate;
  final String timeStart;
  final String timeEnd;
  final String status;
  final int index;

  BoxHistory({
    required this.doctorImage,
    required this.doctorName,
    required this.doctorNote,
    required this.date,
    required this.sameDate,
    required this.timeStart,
    required this.timeEnd,
    required this.status,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !date.endsWith(sameDate) || sameDate.isEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 260, 10),
                  child: Text(
                    date.endsWith(
                            DateFormat('yyyy-MM-dd').format(DateTime.now()))
                        ? "Hôm nay"
                        : date,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              : Container(),
          textfield(
            doctorImage: doctorImage,
            doctorName: doctorName,
            doctorNote: doctorNote,
            timeStart: timeStart,
            timeEnd: timeEnd,
            status: status,
            index: index,
          ),
        ],
      ),
    );
  }

  Widget textfield(
      {@required doctorImage,
      @required doctorName,
      @required doctorNote,
      @required timeStart,
      @required timeEnd,
      @required status,
      @required index,
      onTap}) {
    final patientHistoryController = Get.put(PatientHistoryController());

    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Container(
          height: 180,
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage(
                      doctorImage,
                    ),
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/default_avatar.png", width: 120, height: 120,),
                    width: 120,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        patientHistoryController.index.value = index;
                        Get.to(() => PatientDetailHistoryScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(microseconds: 600));
                      },
                      decoration: InputDecoration(
                          hintText: doctorName,
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                            letterSpacing: 2,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white30,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(110.0, 40, 0, 0),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        patientHistoryController.index.value = index;
                        Get.to(() => PatientDetailHistoryScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(microseconds: 600));
                      },
                      decoration: InputDecoration(
                          hintText: doctorNote,
                          suffixIcon: status == "COMPLETED"
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : status == "CANCELED"
                                  ? Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.watch_later,
                                      color: Colors.amberAccent,
                                    ),
                          hintStyle: TextStyle(
                            letterSpacing: 2,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white30,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(110.0, 80, 0, 0),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        patientHistoryController.index.value = index;
                        Get.to(() => PatientDetailHistoryScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(microseconds: 600));
                      },
                      decoration: InputDecoration(
                          hintText: timeStart + " - " + timeEnd,
                          hintStyle: TextStyle(
                            letterSpacing: 2,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white30,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(290, 80, 0, 0),
                    child: TextField(
                      readOnly: true,
                      style: TextStyle(fontSize: 16, color: kBlueColor),
                      onTap: (){
                        patientHistoryController.index.value = index;
                        Get.to(() => PatientDetailHistoryScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(microseconds: 600));
                      },
                      decoration: InputDecoration(
                        hintText: "View",
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: Colors.white30,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
