import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/edit_healthcheck_info_screen.dart';
import 'package:telemedicine_mobile/Screens/edit_patient_profile_screen.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_history_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
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

  final patientProfileController = Get.put(PatientProfileController());

  @override
  void initState() {
    super.initState();
    patientProfileController.getMyPatient();
    patientProfileController.getMyAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: kBlueColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: kBackgroundColor,
                            image: DecorationImage(
                              image: NetworkImage(patientProfileController
                                          .patient.value.avatar ==
                                      ""
                                  ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                                  : patientProfileController
                                      .patient.value.avatar),
                            ),
                          ),
                        ),
                        Text(
                          patientProfileController.patient.value.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 120, left: 160),
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 25),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    Icons.person,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "My Account",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: kWhiteColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 101,
                                ),
                                RawMaterialButton(
                                  onPressed: () => {
                                    Get.to(() => EditPatientProfile(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 600))
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textfield(
                            hintText:
                                patientProfileController.patient.value.email,
                            icon: Icons.email_outlined,
                          ),
                          textfield(
                            hintText:
                                patientProfileController.dob.value,
                            icon: Icons.date_range,
                          ),
                          textfield(
                            hintText:
                                patientProfileController.account.value.phone,
                            icon: Icons.phone,
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
                                    Icons.person,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "My Health Check Info",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: kWhiteColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                RawMaterialButton(
                                  onPressed: () => {
                                    Get.to(() => EditHealthCheckInfoScreen(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 600))
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textfield(
                            hintText: patientProfileController
                                .patient.value.allergy == null || patientProfileController
                                .patient.value.allergy.isEmpty ? patientProfileController
                                .patient.value.allergy : "No allergies",
                            icon: Icons.ac_unit_outlined,
                          ),
                          textfield(
                            hintText: patientProfileController
                                        .patient.value.bloodGroup ==
                                    null || patientProfileController
                                .patient.value.bloodGroup.isEmpty
                                ? "Undefined"
                                : patientProfileController
                                    .patient.value.bloodGroup,
                            icon: Icons.bloodtype_outlined,
                          ),
                          textfield(
                            hintText: patientProfileController
                                .patient.value.backgroundDisease == null || patientProfileController
                                .patient.value.backgroundDisease.isEmpty ? "No background disease" : patientProfileController
                                .patient.value.backgroundDisease,
                            icon: Icons.ac_unit_outlined,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              //Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Icon(
                                    Icons.contact_support,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "General",
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
                            hintText: 'History',
                            icon: Icons.history,
                            onTap: () => {
                              Get.to(() => PatientHistoryScreen(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(microseconds: 600))
                            },
                          ),
                          textfield(
                            hintText: 'Logout',
                            icon: Icons.logout,
                            onTap: () => {
                              Get.offAll(() => LoginScreen(),
                                  duration: Duration(microseconds: 600))
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
