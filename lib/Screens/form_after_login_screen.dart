import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
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
  TextEditingController textStreetController = TextEditingController();

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
              child: Obx(
                () => Column(
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/default_avatar.png'),
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
                    SizedBox(height: 20),
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
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textFirstNameController,
                            decoration: InputDecoration(
                              hintText: "First Name",
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
                            "Last Name:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 5, 0, 0),
                          child: Radio(
                            value: "Male",
                            groupValue:
                                formAfterLoginController.selectedGender.value,
                            onChanged: (value) {
                              formAfterLoginController.selectedGender.value = value.toString();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(140, 18, 0, 0),
                          child: Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 18,
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
                              formAfterLoginController.selectedGender.value = value.toString();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(260, 18, 0, 0),
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 18,
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
                                  formAfterLoginController.pickDate(context),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 103),
                                child: Text(
                                  formAfterLoginController.dob.value.year >=
                                              DateTime.now().year &&
                                          formAfterLoginController
                                                  .dob.value.month >=
                                              DateTime.now().month &&
                                          formAfterLoginController
                                                  .dob.value.day >=
                                              DateTime.now().day
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
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
                              onChanged: (value) {
                                formAfterLoginController.provinceOrCity.value = value.toString();
                                formAfterLoginController.provinceIsSelect.value = true;
                                formAfterLoginController.setListDistrict(value);
                                formAfterLoginController.changeProvinceSelect();
                              },
                              value: formAfterLoginController
                                      .provinceOrCity.value.isEmpty
                                  ? null
                                  : formAfterLoginController
                                      .provinceOrCity.value,
                              isExpanded: true,
                              items: formAfterLoginController.provinceData
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
                              onChanged: (value) {
                                formAfterLoginController.district.value = value.toString();
                                formAfterLoginController.districtIsSelect.value = true;
                                formAfterLoginController.ward.value = "";
                                formAfterLoginController.setListWard(value);
                              },
                              value: formAfterLoginController
                                      .district.value.isEmpty
                                  ? null
                                  : formAfterLoginController.district.value,
                              isExpanded: true,
                              items: formAfterLoginController.districtData
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
                              onChanged: (value) {
                                formAfterLoginController.ward.value = value.toString();
                              },
                              value: formAfterLoginController.ward.value.isEmpty
                                  ? null
                                  : formAfterLoginController.ward.value,
                              isExpanded: true,
                              items: formAfterLoginController.wardData
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
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 17, 20, 0),
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
                              hintText: "Street",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
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
