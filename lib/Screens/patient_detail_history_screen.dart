import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:telemedicine_mobile/Screens/view_drug_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/doctor_detail_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class PatientDetailHistoryScreen extends StatefulWidget {
  const PatientDetailHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientDetailHistoryScreenState createState() =>
      _PatientDetailHistoryScreenState();
}

class _PatientDetailHistoryScreenState
    extends State<PatientDetailHistoryScreen> {
  final patientHistoryController = Get.put(PatientHistoryController());
  final doctorDetailController = Get.put(DoctorDetailController());
  final listDoctorController = Get.put(ListDoctorController());
  final patientProfileController = Get.put(PatientProfileController());

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

  var symptom;

  @override
  void initState() {
    super.initState();
    doctorDetailController.getDoctorDetail(patientHistoryController
        .listHealthCheck[patientHistoryController.index.value]
        .slots[0]
        .doctor
        .email);
    listDoctorController.getAllDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chi tiết cuộc hẹn"),
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
        child: Obx(
          () => Container(
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    patientHistoryController
                                .listHealthCheck[
                                    patientHistoryController.index.value]
                                .status ==
                            "CANCELED"
                        ? Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 60,
                          )
                        : patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .status ==
                                "COMPLETED"
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 60,
                              )
                            : Icon(
                                Icons.watch_later,
                                color: Colors.yellow,
                                size: 60,
                              ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      patientHistoryController
                                  .listHealthCheck[
                                      patientHistoryController.index.value]
                                  .status ==
                              "CANCELED"
                          ? "Buổi tư vấn đã được hủy"
                          : patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .status ==
                                  "COMPLETED"
                              ? "Buổi tư vấn đã hoàn thành"
                              : "Buổi tư vấn sắp đến",
                      style: TextStyle(
                        fontSize: 22,
                        color: patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .status ==
                                "CANCELED"
                            ? Colors.red
                            : patientHistoryController
                                        .listHealthCheck[
                                            patientHistoryController
                                                .index.value]
                                        .status ==
                                    "COMPLETED"
                                ? Colors.green
                                : Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () => {},
                              initialValue: "Thông tin cuộc hẹn",
                              style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.white,
                                ),
                                fillColor: kBlueColor,
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          textfield(
                            hintText: "Ngày: " +
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                    patientHistoryController
                                        .listHealthCheck[
                                            patientHistoryController
                                                .index.value]
                                        .createdTime)),
                            icon: Icons.date_range_rounded,
                          ),
                          textfield(
                            hintText: "Giờ: " +
                                patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .slots[0]
                                    .startTime
                                    .toString()
                                    .replaceRange(5, 8, "") +
                                " - " +
                                patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .slots[0]
                                    .endTime
                                    .toString()
                                    .replaceRange(5, 8, ""),
                            icon: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () => {
                                listDoctorController.getDoctorDetailByEmail(
                                    patientHistoryController
                                        .listHealthCheck[
                                            patientHistoryController
                                                .index.value]
                                        .slots[0]
                                        .doctor
                                        .email),
                                listDoctorController.getListDoctorSlot(
                                    listDoctorController.doctorDetail.value.id),
                                patientProfileController.getMyPatient(),
                                Get.to(
                                    () => DetailScreen(
                                        listDoctorController
                                            .doctorDetail.value.name,
                                        listDoctorController
                                            .doctorDetail.value.scopeOfPractice,
                                        listDoctorController
                                            .doctorDetail.value.description,
                                        listDoctorController
                                            .doctorDetail.value.avatar,
                                        listDoctorController
                                            .doctorDetail.value.majorDoctors,
                                        listDoctorController
                                            .doctorDetail.value.hospitalDoctors,
                                        listDoctorController.doctorDetail.value
                                            .certificationDoctors,
                                        listDoctorController
                                            .doctorDetail.value.rating,
                                        listDoctorController.doctorDetail.value
                                            .numberOfConsultants,
                                        listDoctorController.doctorDetail.value
                                            .dateOfCertificate),
                                    transition: Transition.rightToLeftWithFade,
                                    duration: Duration(microseconds: 600)),
                              },
                              initialValue: "Thông tin bác sĩ",
                              style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.medical_services,
                                  color: Colors.white,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                fillColor: kBlueColor,
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          textfield(
                            hintText: "Tên: " +
                                patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .slots[0]
                                    .doctor
                                    .name,
                            icon: Icons.person,
                          ),
                          textfield(
                            hintText: doctorDetailController
                                    .doctorDetail.value.dob.isEmpty
                                ? ""
                                : "Ngày sinh: " +
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(doctorDetailController
                                            .doctorDetail.value.dob)),
                            icon: Icons.date_range_rounded,
                          ),
                          textfield(
                            hintText:
                                doctorDetailController.doctorDetail.value.isMale
                                    ? "Giới tính: Nam"
                                    : "Giới tính: Nữ",
                            icon:
                                doctorDetailController.doctorDetail.value.isMale
                                    ? Icons.male
                                    : Icons.female,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .status ==
                                  "COMPLETED"
                              ? InkWell(
                                  onTap: () => {
                                    Get.to(() => ViewDrugScreen(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: Duration(microseconds: 600)),
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kBlueColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Đơn thuốc",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .status ==
                                  "CANCELED"
                              ? Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Text(
                                        "Lý do:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 60),
                                        child: Text(
                                          patientHistoryController
                                                      .listHealthCheck[
                                                          patientHistoryController
                                                              .index.value]
                                                      .reasonCancel ==
                                                  null
                                              ? ""
                                              : patientHistoryController
                                                  .listHealthCheck[
                                                      patientHistoryController
                                                          .index.value]
                                                  .reasonCancel,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
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
