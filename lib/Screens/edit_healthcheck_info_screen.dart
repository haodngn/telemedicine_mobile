import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class EditHealthCheckInfoScreen extends StatefulWidget {
  const EditHealthCheckInfoScreen({Key? key}) : super(key: key);

  @override
  _EditHealthCheckInfoScreenState createState() =>
      _EditHealthCheckInfoScreenState();
}

class _EditHealthCheckInfoScreenState extends State<EditHealthCheckInfoScreen> {
  final patientProfileController = Get.put(PatientProfileController());
  final bottomNavbarController = Get.put(BottomNavbarController());

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
          "Chỉnh sửa thông tin sức khỏe",
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
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dị ứng:",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: textAllergyController,
                          decoration: InputDecoration(
                            hintText: patientProfileController
                                        .patient.value.allergy.isEmpty
                                ? "Không bị dị ứng"
                                : patientProfileController
                                    .patient.value.allergy,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nhóm máu:",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: textBloodTypeController,
                          decoration: InputDecoration(
                            hintText: patientProfileController
                                        .patient.value.bloodGroup.isEmpty
                                ? "Chưa xác định"
                                : patientProfileController
                                    .patient.value.bloodGroup,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Bệnh nền:",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      maxLines: 5,
                      controller: textBackgroundDiseaseController,
                      decoration: InputDecoration(
                        hintText: patientProfileController
                                    .patient.value.backgroundDisease.isEmpty
                            ? "Không có bệnh nền"
                            : patientProfileController
                                .patient.value.backgroundDisease,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        onPressed: () => {
                          Fluttertoast.showToast(msg: "Đã lưu", fontSize: 18),
                          patientProfileController.updatePatientInfo(
                              textBackgroundDiseaseController.text,
                              textAllergyController.text,
                              textBloodTypeController.text),
                          bottomNavbarController.currentIndex.value = 3,
                          Get.to(() => BottomNavScreen(),
                              transition: Transition.rightToLeftWithFade,
                              duration: Duration(milliseconds: 600))
                        },
                        child: Text(
                          "Lưu",
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
