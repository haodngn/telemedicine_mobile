import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
                      "Chào mừng bạn đến với",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Text(
                      "Ứng dụng bác sĩ tư vấn trực tuyến",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: InkWell(
                        onTap: () => {_showOptions(context)},
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                          ),
                          child:
                              formAfterLoginController.image.value.path.isEmpty
                                  ? Image(
                                      image: AssetImage(
                                          'assets/images/default_avatar.png'))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        formAfterLoginController.image.value,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    formAfterLoginController.emptyImage.value ? Center(
                      child: Text(
                        "Vui lòng chọn ảnh đại diện",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ) : Container(),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Họ:",
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
                              hintText: "Họ",
                              border: OutlineInputBorder(),
                              errorText:
                                  formAfterLoginController.emptyFName.value
                                      ? "Vui lòng nhập họ của bạn"
                                      : null,
                              errorStyle: TextStyle(fontSize: 14),
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
                            "Tên:",
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
                              hintText: "Tên",
                              border: OutlineInputBorder(),
                              errorText:
                                  formAfterLoginController.emptyLName.value
                                      ? "Vui lòng nhập tên của bạn"
                                      : null,
                              errorStyle: TextStyle(fontSize: 14),
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
                            "Giới tính:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 5, 0, 0),
                          child: Radio(
                            value: "Nam",
                            groupValue:
                                formAfterLoginController.selectedGender.value,
                            onChanged: (value) {
                              formAfterLoginController.selectedGender.value =
                                  value.toString();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(140, 18, 0, 0),
                          child: Text(
                            "Nam",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 5, 0, 0),
                          child: Radio(
                            value: "Nữ",
                            groupValue:
                                formAfterLoginController.selectedGender.value,
                            onChanged: (value) {
                              formAfterLoginController.selectedGender.value =
                                  value.toString();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(260, 18, 0, 0),
                          child: Text(
                            "Nữ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    formAfterLoginController.emptyGender.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 110),
                            child: Text(
                              "Vui lòng chọn giới tính của bạn",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                          child: Text(
                            "Ngày sinh:",
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
                                padding: const EdgeInsets.only(right: 106),
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
                                      : DateFormat('yyyy-MM-dd').format(
                                          formAfterLoginController.dob.value),
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
                    formAfterLoginController.emptyDOB.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 110),
                            child: Text(
                              "Vui lòng chọn ngày sinh của bạn",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            "Điện thoại:",
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
                              hintText: "Số điện thoại",
                              border: OutlineInputBorder(),
                              errorText:
                                  formAfterLoginController.emptyPhone.value
                                      ? "Vui lòng nhập số điện thoại"
                                      : null,
                              errorStyle: TextStyle(fontSize: 14),
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
                            "Thành phố:",
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
                                child: Text("Chọn Tỉnh/Thành phố"),
                              ),
                              onChanged: (value) {
                                formAfterLoginController.provinceOrCity.value =
                                    value.toString();
                                formAfterLoginController
                                    .provinceIsSelect.value = true;
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
                    formAfterLoginController.emptyCity.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 110),
                            child: Text(
                              "Vui lòng chọn thành phố bạn ở",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "Quận:",
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
                                child: Text("Chọn Quận/Huyện"),
                              ),
                              onChanged: (value) {
                                formAfterLoginController.district.value =
                                    value.toString();
                                formAfterLoginController
                                    .districtIsSelect.value = true;
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
                    formAfterLoginController.emptyDistrict.value
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
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Text(
                            "Phường:",
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
                                child: Text("Chọn Phường/Xã"),
                              ),
                              onChanged: (value) {
                                formAfterLoginController.ward.value =
                                    value.toString();
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
                    formAfterLoginController.emptyWard.value
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
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 17, 20, 0),
                          child: Text(
                            "Đường:",
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
                              hintText: "Đường",
                              border: OutlineInputBorder(),
                              errorText:
                                  formAfterLoginController.emptyStreet.value
                                      ? "Vui lòng nhập địa chỉ của bạn"
                                      : null,
                              errorStyle: TextStyle(fontSize: 14),
                            ),
                            keyboardType: TextInputType.name,
                          ),
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
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 17, 20, 0),
                          child: Text(
                            "Dị ứng:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textAllergyController,
                            decoration: InputDecoration(
                              hintText: "Dị ứng",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
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
                            "Nhóm máu:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textBloodGroupController,
                            decoration: InputDecoration(
                              hintText: "Nhóm máu",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
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
                            "Bệnh nền:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: TextField(
                            controller: textBackgroundDiseaseController,
                            decoration: InputDecoration(
                              hintText: "Bệnh nền",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
