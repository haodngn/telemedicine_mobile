import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
import 'package:telemedicine_mobile/constant.dart';

class EditPatientProfile extends StatefulWidget {
  const EditPatientProfile({Key? key}) : super(key: key);

  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textStreetAddressController = TextEditingController();
  TextEditingController textLocalityController = TextEditingController();
  TextEditingController textCityController = TextEditingController();
  TextEditingController textPostalCodeController = TextEditingController();
  TextEditingController textHeightController = TextEditingController();
  TextEditingController textWeightController = TextEditingController();
  TextEditingController textAllergyController = TextEditingController();
  TextEditingController textBloodGroupController = TextEditingController();
  TextEditingController textBackgroundDiseaseController = TextEditingController();

  var selectedGender;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedGender = "Female";
    });
  }

  setSelectedGender(var value) {
    setState(() {
      selectedGender = value;
    });
  }

  late DateTime dob = DateTime.now();

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));

    if (newDate == null) return;

    setState(() {
      dob = newDate as DateTime;
    });
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
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
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
                              image: AssetImage('assets/images/default_avatar.png'),
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
                          "Name:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: TextField(
                          controller: textFirstNameController,
                          decoration: InputDecoration(
                            hintText: "Nguyen Van A",
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
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 5, 0, 0),
                        child: Radio(
                          value: "Male",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setSelectedGender(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(120, 18, 0, 0),
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
                          value: "Female",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setSelectedGender(value);
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
                            fontSize: 22,
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
                        padding: const EdgeInsets.only(left: 80),
                        child: OutlinedButton(
                          onPressed: () => pickDate(context),
                          child: Text(
                            dob.year >= DateTime.now().year
                                ? "10/7/2000                                                              "
                                : "${dob.day}/${dob.month}/${dob.year}                                   ",
                            style: TextStyle(fontSize: 18, color: Colors.black),
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
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: TextField(
                          controller: textPhoneController,
                          decoration: InputDecoration(
                            hintText: "+84 123456789",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
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
                          "Email:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: TextField(
                          controller: textEmailController,
                          decoration: InputDecoration(
                            hintText: "user@gmail.com",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
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
    );
  }
}
