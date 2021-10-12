import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/view_drug_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/models/History.dart';

class PatientDetailHistoryScreen extends StatefulWidget {
  const PatientDetailHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientDetailHistoryScreenState createState() =>
      _PatientDetailHistoryScreenState();
}

class _PatientDetailHistoryScreenState
    extends State<PatientDetailHistoryScreen> {
  History history = new History(
    doctorImage: "assets/images/doctor1.png",
    doctorName: "Nguyen Van Tam",
    doctorNote: "Kiểm tra lần 3",
    date: "06/10/2021",
    timeStart: "10:00",
    timeEnd: "11:30",
    status: "Done",
  );

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
        title: Text("Detail History"),
        backgroundColor: kBlueColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  history.status == "Cancel"
                      ? Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 60,
                        )
                      : history.status == "Done"
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 60,
                            )
                          : Icon(
                              Icons.watch_later,
                              color: Colors.yellow,
                              size: 60,
                            ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    history.status == "Cancel"
                        ? "This health check is cancel"
                        : history.status == "Done"
                            ? "This health check is done"
                            : "This health check is coming",
                    style: TextStyle(
                      fontSize: 22,
                      color: history.status == "Cancel"
                          ? Colors.red
                          : history.status == "Done"
                              ? Colors.green
                              : Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: kBlueColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: kWhiteColor,
                                ),
                              ),
                              Text(
                                "Appointment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        textfield(
                          hintText: "Date: 06/10/2021",
                          icon: Icons.date_range_rounded,
                        ),
                        textfield(
                          hintText: "Time: 01:00 - 02:30",
                          icon: Icons.watch_later_outlined,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: kBlueColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Icon(
                                  Icons.perm_contact_cal_rounded,
                                  color: kWhiteColor,
                                ),
                              ),
                              Text(
                                "Doctor",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        textfield(
                          hintText: "Name: Nguyen Van Tam",
                          icon: Icons.person,
                        ),
                        textfield(
                          hintText: "Dob: 10/07/2000",
                          icon: Icons.date_range_rounded,
                        ),
                        textfield(
                          hintText: "Gender: Male",
                          icon: Icons.male,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        history.status == "Done"
                            ? Container(
                                width: double.infinity,
                                child: Text(
                                  "Advices of doctor:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        history.status == "Done"
                            ? TextField(
                          readOnly: true,
                                maxLines: 5,
                                // controller: textBackgroundDiseaseController,
                                decoration: InputDecoration(
                                  hintText: "aaa",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.name,
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        history.status == "Done"
                            ? Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kBlueColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextFormField(
                                  readOnly: true,
                                  onTap: () => Get.to(() => ViewDrugScreen(),
                                      transition:
                                          Transition.rightToLeftWithFade,
                                      duration: Duration(microseconds: 600)),
                                  initialValue: "Your Prescription",
                                  style: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.medical_services,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    fillColor: kBlueColor,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                            : Container(),
                        history.status == "Cancel"
                            ? Container(
                                width: double.infinity,
                                child: Text(
                                  "Reason:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        history.status == "Cancel"
                            ? TextField(
                                maxLines: 5,
                                // controller: textBackgroundDiseaseController,
                                decoration: InputDecoration(
                                  // labelText: "The reason",
                                  hintText: "I'm busy with unexpected work",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.name,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
