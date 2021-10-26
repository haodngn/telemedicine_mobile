import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
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
    patientProfileController.image = new File("").obs;
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 120,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      patientProfileController.pickImage(ImageSource.camera);
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Chụp ảnh từ camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      patientProfileController.pickImage(ImageSource.gallery);
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Chọn ảnh trong máy"))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa thông tin cá nhân",
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () => _showOptions(context),
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              patientProfileController.image.value.path.isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(patientProfileController
                                                    .patient.value.avatar ==
                                                ""
                                            ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                                            : patientProfileController
                                                .patient.value.avatar),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        patientProfileController.image.value,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              Positioned(
                                  child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[200],
                                  child: IconButton(
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      _showOptions(context);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Họ:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: textFirstNameController,
                        decoration: InputDecoration(
                          hintText:
                              patientProfileController.account.value.firstName,
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
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: textLastNameController,
                        decoration: InputDecoration(
                          hintText:
                              patientProfileController.account.value.lastName,
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
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giới tính:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                patientProfileController.isMale.value = true;
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: true,
                                      groupValue:
                                          patientProfileController.isMale.value,
                                      onChanged: (newValue) {
                                        patientProfileController.isMale.value =
                                            true;
                                      },
                                    ),
                                    Text(
                                      "Nam",
                                      style: TextStyle(
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                patientProfileController.isMale.value = false;
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: false,
                                      groupValue:
                                          patientProfileController.isMale.value,
                                      onChanged: (newValue) {
                                        patientProfileController.isMale.value =
                                            false;
                                      },
                                    ),
                                    Text(
                                      "Nữ",
                                      style: TextStyle(
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ngày sinh:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            left: 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.calendar_today_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            child: OutlinedButton(
                              onPressed: () =>
                                  patientProfileController.pickDate(context),
                              child: Text(
                                patientProfileController.dob.value,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Điện thoại:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thành phố:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Chọn Tỉnh/Thành phố"),
                            ),
                            onChanged: (newValue) {
                              patientProfileController.city.value =
                                  newValue.toString();
                              patientProfileController
                                  .setListDistrict(newValue);
                              patientProfileController.district.value = "";
                              patientProfileController.ward.value = "";
                              patientProfileController.listWard.value = [];
                            },
                            value: patientProfileController.city.value ==
                                        null ||
                                    patientProfileController.city.value == ""
                                ? null
                                : patientProfileController.city.value,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quận:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Chọn Quận/Huyện"),
                            ),
                            onChanged: (newValue) {
                              patientProfileController.district.value =
                                  newValue.toString();
                              patientProfileController.ward.value = "";
                              patientProfileController.setListWard(newValue);
                            },
                            value: patientProfileController.district.value ==
                                        null ||
                                    patientProfileController.district.value ==
                                        ""
                                ? null
                                : patientProfileController.district.value,
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
                  patientProfileController.district.value.isEmpty &&
                          patientProfileController.emptyDistrict.value
                      ? Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Text(
                            "Vui lòng chọn quận, huyện",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phường:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Chọn Phường/Xã"),
                            ),
                            onChanged: (newValue) {
                              patientProfileController.ward.value =
                                  newValue.toString();
                            },
                            value: patientProfileController.ward.value ==
                                        null ||
                                    patientProfileController.ward.value == ""
                                ? null
                                : patientProfileController.ward.value,
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
                  patientProfileController.ward.value.isEmpty &&
                          patientProfileController.emptyWard.value
                      ? Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Text(
                            "Vui lòng chọn phường, xã",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đường:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
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
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      onPressed: () => {
                        patientProfileController.updateAccountInfo(
                            textFirstNameController.text,
                            textLastNameController.text,
                            textPhoneController.text,
                            textStreetController.text),
                        if (patientProfileController.done.value)
                          {
                            Get.to(() => PatientProfile(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600))
                          }
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
                  SizedBox(
                    height: 22,
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
