import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  TextEditingController textStreetController = TextEditingController();
  TextEditingController textAllergyController = TextEditingController();
  TextEditingController textBloodGroupController = TextEditingController();
  TextEditingController textBackgroundDiseaseController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    formAfterLoginController.getAddress();
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
                      formAfterLoginController.pickImage(ImageSource.camera);
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Chụp ảnh từ camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      formAfterLoginController.pickImage(ImageSource.gallery);
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Chọn ảnh trong máy"))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chào mừng bạn đến với",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Text(
                              "Ứng dụng bác sĩ tư vấn trực tuyến",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 30),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: InkWell(
                                onTap: () => _showOptions(context),
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    height:
                                        MediaQuery.of(context).size.width / 1.8,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 5),
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        formAfterLoginController
                                                .image.value.path.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: Image(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/images/default_avatar.png')),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: Image.file(
                                                  formAfterLoginController
                                                      .image.value,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ],
                                    )),
                              ),
                            ),
                            formAfterLoginController.emptyImage.value
                                ? Center(
                                    child: Text(
                                      "Vui lòng chọn ảnh đại diện",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 20),
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
                                    hintText: "Họ",
                                    border: OutlineInputBorder(),
                                    errorText: formAfterLoginController
                                            .emptyFName.value
                                        ? "Vui lòng nhập họ của bạn"
                                        : null,
                                    errorStyle: TextStyle(fontSize: 14),
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
                                    hintText: "Tên",
                                    border: OutlineInputBorder(),
                                    errorText: formAfterLoginController
                                            .emptyLName.value
                                        ? "Vui lòng nhập tên của bạn"
                                        : null,
                                    errorStyle: TextStyle(fontSize: 14),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          formAfterLoginController
                                              .selectedGender.value = true;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: true,
                                                groupValue:
                                                    formAfterLoginController
                                                        .selectedGender.value,
                                                onChanged: (newValue) {
                                                  formAfterLoginController
                                                      .selectedGender
                                                      .value = true;
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
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          formAfterLoginController
                                              .selectedGender.value = false;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: false,
                                                groupValue:
                                                    formAfterLoginController
                                                        .selectedGender.value,
                                                onChanged: (newValue) {
                                                  formAfterLoginController
                                                      .selectedGender
                                                      .value = false;
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
                                ),
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
                                      height: 50,
                                      child: OutlinedButton(
                                        onPressed: () =>
                                            formAfterLoginController
                                                .pickDate(context),
                                        child: Text(
                                          formAfterLoginController
                                                          .dob.value.year >=
                                                      DateTime.now().year &&
                                                  formAfterLoginController
                                                          .dob.value.month >=
                                                      DateTime.now().month &&
                                                  formAfterLoginController
                                                          .dob.value.day >=
                                                      DateTime.now().day
                                              ? ""
                                              : DateFormat('yyyy-MM-dd').format(
                                                  formAfterLoginController
                                                      .dob.value),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            formAfterLoginController.emptyDOB.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      "Vui lòng chọn ngày sinh của bạn",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  )
                                : Container(),
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
                                    hintText: "Số điện thoại",
                                    border: OutlineInputBorder(),
                                    errorText: formAfterLoginController
                                            .emptyPhone.value
                                        ? "Vui lòng nhập số điện thoại"
                                        : null,
                                    errorStyle: TextStyle(fontSize: 14),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text("Chọn Tỉnh/Thành phố"),
                                      ),
                                      onChanged: (value) {
                                        formAfterLoginController.provinceOrCity
                                            .value = value.toString();
                                        formAfterLoginController
                                            .provinceIsSelect.value = true;
                                        formAfterLoginController
                                            .setListDistrict(value);
                                        formAfterLoginController
                                            .changeProvinceSelect();
                                      },
                                      value: formAfterLoginController
                                              .provinceOrCity.value.isEmpty
                                          ? null
                                          : formAfterLoginController
                                              .provinceOrCity.value,
                                      isExpanded: true,
                                      items: formAfterLoginController
                                          .provinceData
                                          .map((x) => x.name)
                                          .map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
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
                            formAfterLoginController.emptyCity.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      "Vui lòng chọn thành phố bạn ở",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  )
                                : Container(),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text("Chọn Quận/Huyện"),
                                      ),
                                      onChanged: (value) {
                                        formAfterLoginController
                                            .district.value = value.toString();
                                        formAfterLoginController
                                            .districtIsSelect.value = true;
                                        formAfterLoginController.ward.value =
                                            "";
                                        formAfterLoginController
                                            .setListWard(value);
                                      },
                                      value: formAfterLoginController
                                              .district.value.isEmpty
                                          ? null
                                          : formAfterLoginController
                                              .district.value,
                                      isExpanded: true,
                                      items: formAfterLoginController
                                          .districtData
                                          .map((x) => x.name)
                                          .map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
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
                            formAfterLoginController.emptyDistrict.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      "Vui lòng chọn quận, huyện",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text("Chọn Phường/Xã"),
                                      ),
                                      onChanged: (value) {
                                        formAfterLoginController.ward.value =
                                            value.toString();
                                      },
                                      value: formAfterLoginController
                                              .ward.value.isEmpty
                                          ? null
                                          : formAfterLoginController.ward.value,
                                      isExpanded: true,
                                      items: formAfterLoginController.wardData
                                          .map((x) => x.name)
                                          .map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
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
                            formAfterLoginController.emptyWard.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      "Vui lòng chọn phường, xã",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
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
                                    hintText: "Đường",
                                    border: OutlineInputBorder(),
                                    errorText: formAfterLoginController
                                            .emptyStreet.value
                                        ? "Vui lòng nhập địa chỉ của bạn"
                                        : null,
                                    errorStyle: TextStyle(fontSize: 14),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Thông tin sức khỏe",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                    hintText: "Dị ứng",
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
                                  "Nhóm máu:",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: textBloodGroupController,
                                  decoration: InputDecoration(
                                    hintText: "Nhóm máu",
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
                                  "Bệnh nền:",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: textBackgroundDiseaseController,
                                  decoration: InputDecoration(
                                    hintText: "Bệnh nền",
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                onPressed: () => {
                                  formAfterLoginController.createAccountPatient(
                                      textFirstNameController.text,
                                      textLastNameController.text,
                                      textPhoneController.text,
                                      textStreetController.text,
                                      textAllergyController.text,
                                      textBloodGroupController.text,
                                      textBackgroundDiseaseController.text),
                                },
                                child: Text(
                                  "Hoàn tất",
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
                      ],
                    ),
                  ),
                ),
              ),
              formAfterLoginController.isLoading.value
                  ? Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.black.withOpacity(0.5),
                      child: Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: formAfterLoginController.isLoading.value
                              ? CircularProgressIndicator(color: kWhiteColor)
                              : Container(),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
