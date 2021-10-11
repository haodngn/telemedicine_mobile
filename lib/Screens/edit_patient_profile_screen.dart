import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class EditPatientProfile extends StatefulWidget {
  const EditPatientProfile({Key? key}) : super(key: key);

  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  final patientProfileController = Get.put(PatientProfileController());

  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textStreetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    patientProfileController.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(patientProfileController
                                            .patient.value.avatar ==
                                        ""
                                    ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                                    : patientProfileController
                                        .patient.value.avatar),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(150, 150, 0, 0),
                            child: Icon(Icons.camera_alt_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "First Name:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: TextField(
                            controller: textFirstNameController,
                            decoration: InputDecoration(
                              hintText: patientProfileController
                                  .account.value.firstName,
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
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Last Name:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: TextField(
                            controller: textLastNameController,
                            decoration: InputDecoration(
                              hintText: patientProfileController
                                  .account.value.lastName,
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
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Gender:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 5, 0, 0),
                          child: Radio(
                            value: true,
                            groupValue: patientProfileController.isMale.value,
                            onChanged: (newValue) {
                              patientProfileController.isMale.value = true;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(140, 18, 0, 0),
                          child: Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 5, 0, 0),
                          child: Radio(
                            value: false,
                            groupValue: patientProfileController.isMale.value,
                            onChanged: (newValue) {
                              patientProfileController.isMale.value = false;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(260, 18, 0, 0),
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                          child: Text(
                            "DOB:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(294, 8, 0, 0),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () =>
                                  patientProfileController.pickDate(context),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 103),
                                child: Text(
                                  patientProfileController.dob.value,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Phone:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: TextField(
                            controller: textPhoneController,
                            decoration: InputDecoration(
                              hintText:
                                  patientProfileController.account.value.phone,
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
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Text(
                            "City:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 20, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Select City"),
                              ),
                              onChanged: (newValue) {
                                patientProfileController.city.value = newValue.toString();
                                patientProfileController.setListDistrict(newValue);
                                patientProfileController.district.value = "";
                                patientProfileController.ward.value = "";
                                patientProfileController.listWard.value = [];
                              },
                              value: patientProfileController.city.value,
                              isExpanded: true,
                              items: patientProfileController.listCity
                                  .map((x) => x.name)
                                  .map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(
                                          color: Colors.black,
                                          //Color(0xff6200ee),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "District:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Select District"),
                              ),
                              onChanged: (newValue) {
                                patientProfileController.district.value = newValue.toString();
                                patientProfileController.ward.value = "";
                                patientProfileController.setListWard(newValue);
                              },
                              value: patientProfileController.district.value.isEmpty ? null : patientProfileController.district.value,
                              isExpanded: true,
                              items: patientProfileController.listDistrict
                                  .map((x) => x.name)
                                  .map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(
                                          color: Colors.black,
                                          //Color(0xff6200ee),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Text(
                            "Ward:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Select Ward"),
                              ),
                              onChanged: (newValue) {
                                patientProfileController.ward.value = newValue.toString();
                              },
                              value: patientProfileController.ward.value.isEmpty ? null : patientProfileController.ward.value,
                              isExpanded: true,
                              items: patientProfileController.listWard
                                  .map((x) => x.name)
                                  .map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
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
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Street:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textStreetController,
                            decoration: InputDecoration(
                              hintText: patientProfileController
                                  .account.value.streetAddress,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(240, 20, 0, 0),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        onPressed: () => patientProfileController.abc(),
                        // Get.to(() => PatientProfile(),
                        // transition: Transition.rightToLeftWithFade,
                        // duration: Duration(milliseconds: 600)),
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
