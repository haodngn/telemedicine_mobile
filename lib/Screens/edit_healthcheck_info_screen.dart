import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class EditHealthCheckInfoScreen extends StatefulWidget {
  const EditHealthCheckInfoScreen({Key? key}) : super(key: key);

  @override
  _EditHealthCheckInfoScreenState createState() =>
      _EditHealthCheckInfoScreenState();
}

class _EditHealthCheckInfoScreenState extends State<EditHealthCheckInfoScreen> {
  final patientProfileController = Get.put(PatientProfileController());

  TextEditingController textHeightController = TextEditingController();
  TextEditingController textWeightController = TextEditingController();
  TextEditingController textAllergyController = TextEditingController();
  TextEditingController textBloodTypeController = TextEditingController();
  TextEditingController textBackgroundDiseaseController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Health Check Info",
          style: TextStyle(color: Colors.white),
        ),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                          child: Text(
                            "Allergy:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: TextField(
                            controller: textAllergyController,
                            decoration: InputDecoration(
                              hintText:
                              patientProfileController.patient.value.allergy == null || patientProfileController.patient.value.allergy.isEmpty ? "No allergies" : patientProfileController.patient.value.allergy,
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                          child: Text(
                            "Blood Type:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textBloodTypeController,
                            decoration: InputDecoration(
                              hintText:
                              patientProfileController.patient.value.bloodGroup == null || patientProfileController.patient.value.bloodGroup.isEmpty ? "Undefined" : patientProfileController.patient.value.bloodGroup,
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                      child: Text(
                        "Background Disease:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                      child: TextField(
                        maxLines: 5,
                        controller: textBackgroundDiseaseController,
                        decoration: InputDecoration(
                          hintText: patientProfileController.patient.value.backgroundDisease == null || patientProfileController.patient.value.backgroundDisease.isEmpty ? "No background disease" : patientProfileController.patient.value.backgroundDisease,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(240, 20, 0, 0),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        onPressed: () => Get.to(() => PatientProfile(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600)),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
