import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/models/History.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientHistoryScreenState createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  final patientHistoryController = Get.put(PatientHistoryController());

  List<History> listHistory = [
    new History(
      doctorImage: "assets/images/doctor1.png",
      doctorName: "Nguyen Van Tam",
      doctorNote: "Kiểm tra lần 3",
      date: "06/10/2021",
      timeStart: "10:00",
      timeEnd: "11:30",
      status: "Wait",
    ),
    new History(
      doctorImage: "assets/images/doctor2.png",
      doctorName: "Le Trong Nhan",
      doctorNote: "Kiểm tra lần 1",
      date: "06/10/2021",
      timeStart: "01:00",
      timeEnd: "02:30",
      status: "Done",
    ),
    new History(
      doctorImage: "assets/images/doctor3.png",
      doctorName: "Pham Van Danh",
      doctorNote: "Kiểm tra lần 2",
      date: "05/10/2021",
      timeStart: "04:00",
      timeEnd: "05:30",
      status: "Cancel",
    ),
    new History(
      doctorImage: "assets/images/doctor3.png",
      doctorName: "Pham Van Danh",
      doctorNote: "Kiểm tra lần 1",
      date: "05/10/2021",
      timeStart: "04:00",
      timeEnd: "05:30",
      status: "Done",
    ),
    new History(
      doctorImage: "assets/images/doctor1.png",
      doctorName: "Nguyen Van Tam",
      doctorNote: "Kiểm tra lần 2",
      date: "04/10/2021",
      timeStart: "04:00",
      timeEnd: "05:30",
      status: "Done",
    ),
    new History(
      doctorImage: "assets/images/doctor1.png",
      doctorName: "Nguyen Van Tam",
      doctorNote: "Kiểm tra lần 1",
      date: "04/10/2021",
      timeStart: "02:30",
      timeEnd: "04:00",
      status: "Done",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "History",
        )),
        backgroundColor: kBlueColor,
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.only(top: 30),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: listHistory.length,
                    itemBuilder: (BuildContext context, index) {
                      return BoxHistory(
                        doctorImage: listHistory[index].doctorImage,
                        doctorName: listHistory[index].doctorName,
                        doctorNote: listHistory[index].doctorNote,
                        date: listHistory[index].date,
                        sameDate: index > 0 ? listHistory[index - 1].date : "",
                        timeStart: listHistory[index].timeStart,
                        timeEnd: listHistory[index].timeEnd,
                        status: listHistory[index].status,
                      );
                    }),
              )
            ],
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

  BoxHistory({
    required this.doctorImage,
    required this.doctorName,
    required this.doctorNote,
    required this.date,
    required this.sameDate,
    required this.timeStart,
    required this.timeEnd,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !date.endsWith(sameDate) || sameDate.isEmpty ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 260, 10),
            child: Text(
              date.endsWith( DateFormat('dd/MM/yyyy').format(DateTime.now())) ? "Today" : date,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ) : Container(),
          textfield(
              doctorImage: doctorImage,
              doctorName: doctorName,
              doctorNote: doctorNote,
              timeStart: timeStart,
              timeEnd: timeEnd,
              status: status),
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
      onTap}) {
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
                    image: AssetImage(
                      doctorImage,
                    ),
                    width: 120,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0),
                    child: TextField(
                      readOnly: true,
                      onTap: () => Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
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
                      onTap: () => Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
                      decoration: InputDecoration(
                          hintText: doctorNote,
                          suffixIcon: status == "Done"
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : status == "Cancel"
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
                      onTap: () => Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
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
                      onTap: () => Get.to(() => PatientDetailHistoryScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(microseconds: 600)),
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
