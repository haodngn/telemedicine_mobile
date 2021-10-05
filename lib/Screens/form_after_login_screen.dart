import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/controller/formafterlogin_controller.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final formAfterLoginController = Get.put(FormAfterLoginController());

  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textStreetAddressController = TextEditingController();
  TextEditingController textLocalityController = TextEditingController();
  TextEditingController textCityController = TextEditingController();
  TextEditingController textPostalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formAfterLoginController.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to the",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Text(
                      "Counselor App",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
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
                          padding: const EdgeInsets.fromLTRB(80, 0, 140, 0),
                          child: TextField(
                            controller: textFirstNameController,
                            decoration: InputDecoration(
                              hintText: "First Name",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                          child: TextField(
                            controller: textLastNameController,
                            decoration: InputDecoration(
                              hintText: "Last Name",
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
                            groupValue:
                            formAfterLoginController.selectedGender.value,
                            onChanged: (value) {
                              formAfterLoginController
                                  .setSelectedGender(value.toString());
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
                            groupValue:
                            formAfterLoginController.selectedGender.value,
                            onChanged: (value) {
                              formAfterLoginController
                                  .setSelectedGender(value.toString());
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
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => formAfterLoginController.pickDate(context),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 123),
                                child: Text(
                                  formAfterLoginController.dob.value.year >= DateTime.now().year &&
                                      formAfterLoginController.dob.value.month >= DateTime.now().month &&
                                      formAfterLoginController.dob.value.day >= DateTime.now().day
                                      ? ""
                                      : "${formAfterLoginController.dob.value.day}/${formAfterLoginController.dob.value.month}/${formAfterLoginController.dob.value.year}",
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
                              hintText: "Phone number",
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
                              hintText: "Your Email",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Address:",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              onChanged: (newValue) {
                                formAfterLoginController.selectCityOrProvince(newValue);
                                formAfterLoginController.provinceIsSelected();
                                formAfterLoginController.setDistricts(newValue);
                                formAfterLoginController.changeProvinceSelect();
                              },
                              value: formAfterLoginController.provinceOrCity.value,
                              isExpanded: true,
                              items: formAfterLoginController.provinceData.map((x) => x.name).map((valueItem) {
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
                        formAfterLoginController.provinceIsSelect.value ? Padding(
                          padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              onChanged: (newValue) {
                                formAfterLoginController.selectDistrict(newValue);
                                formAfterLoginController.districtIsSelected();
                                formAfterLoginController.setWards(newValue);

                              },
                              value: formAfterLoginController.district.value,
                              isExpanded: true,
                              items: formAfterLoginController.districtData.map((x) => x.name).map((valueItem) {
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
                        ) : Container(),
                        formAfterLoginController.districtIsSelect.value ? Padding(
                          padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton(
                              onChanged: (newValue) {
                                formAfterLoginController.selectWard(newValue);
                              },
                              value: formAfterLoginController.ward.value,
                              isExpanded: true,
                              items: formAfterLoginController.wardData.map((x) => x.name).map((valueItem) {
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
                        ) : Container(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(240, 0, 0, 0),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        onPressed: () => Get.to(BottomNavScreen()),
                        child: Text(
                          "Done",
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
