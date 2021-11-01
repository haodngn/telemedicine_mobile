import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final patientProfileController = Get.put(PatientProfileController());

  Widget textfield({@required hintText, @required icon, onTap}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: TextField(
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(
                icon,
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
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text("Thông báo"),
        centerTitle: true,
        backgroundColor: kBlueColor,
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.only(top: 30),
          color: Colors.white,
          child: Obx(
            () => Column(
              children: [
                Expanded(
                  child: patientProfileController.listNotify.length > 0
                      ? ListView.builder(
                          itemCount: patientProfileController.listNotify.length,
                          itemBuilder: (BuildContext context, index) {
                            return BoxNotification(
                              content: patientProfileController
                                  .listNotify[index].content,
                              doctorName: patientProfileController
                                  .listNotify[index].content,
                              date: DateFormat("dd/MM/yyyy").format(
                                  DateTime.parse(patientProfileController
                                      .listNotify[index].createdDate)),
                              sameDate: index > 0
                                  ? DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(patientProfileController
                                          .listNotify[index].createdDate))
                                  : "",
                            );
                          })
                      : Text(
                          "Bạn chưa có thông báo",
                          style: TextStyle(fontSize: 22),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoxNotification extends StatelessWidget {
  final String content;
  final String doctorName;
  final String date;
  final String sameDate;

  BoxNotification({
    required this.content,
    required this.doctorName,
    required this.date,
    required this.sameDate,
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 200, 10),
                  child: Text(
                    date.endsWith(
                            DateFormat('dd/MM/yyyy').format(DateTime.now()))
                        ? "Hôm nay"
                        : date,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          textfield(
            content: content,
            doctorName: doctorName,
          ),
        ],
      ),
    );
  }

  Widget textfield({@required content, @required doctorName, onTap}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 90,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.notifications,
                  size: 30,
                  color: kWhiteColor,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBlueColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
              child: TextField(
                readOnly: true,
                onTap: () {},
                decoration: InputDecoration(
                    hintText: doctorName,
                    hintStyle: TextStyle(
                      letterSpacing: 2,
                      color: Colors.black,
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
              padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
              child: TextField(
                readOnly: true,
                onTap: () => Get.to(() => PatientDetailHistoryScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(microseconds: 600)),
                decoration: InputDecoration(
                    hintText: content,
                    hintStyle: TextStyle(
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    fillColor: Colors.white30,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
