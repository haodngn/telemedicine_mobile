import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';

class ViewDrugScreen extends StatefulWidget {
  const ViewDrugScreen({Key? key}) : super(key: key);

  @override
  _ViewDrugScreenState createState() => _ViewDrugScreenState();
}

class _ViewDrugScreenState extends State<ViewDrugScreen> {
  final patientHistoryController = Get.put(PatientHistoryController());

  @override
  void initState() {
    super.initState();
    patientHistoryController.sttDrug.value = "morning";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Đơn thuốc"),
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
      body: SingleChildScrollView(
        child: Obx(
          () => patientHistoryController
                      .listHealthCheck[patientHistoryController.index.value]
                      .prescriptions
                      .length >
                  0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xfff6f6f6),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => {
                                patientHistoryController.sttDrug.value =
                                    "morning"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      patientHistoryController.sttDrug.value ==
                                              "morning"
                                          ? kBlueColor
                                          : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Sáng",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttDrug.value ==
                                            "morning"
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () => {
                                patientHistoryController.sttDrug.value =
                                    "afternoon"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      patientHistoryController.sttDrug.value ==
                                              "afternoon"
                                          ? kBlueColor
                                          : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Trưa",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttDrug.value ==
                                            "afternoon"
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () => {
                                patientHistoryController.sttDrug.value =
                                    "evening"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      patientHistoryController.sttDrug.value ==
                                              "evening"
                                          ? kBlueColor
                                          : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Chiều",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttDrug.value ==
                                            "evening"
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: patientHistoryController
                            .listHealthCheck[
                                patientHistoryController.index.value]
                            .prescriptions
                            .length,
                        itemBuilder: (BuildContext context, index) {
                          return patientHistoryController.sttDrug.value ==
                                      "morning" &&
                                  patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[index]
                                          .morningQuantity >
                                      0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 20, 30, 20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 7,
                                            spreadRadius: 5,
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(7, 8)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Tên thuốc: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: patientHistoryController
                                                      .listHealthCheck[
                                                          patientHistoryController
                                                              .index.value]
                                                      .prescriptions[index]
                                                      .drug
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Loại thuốc: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: patientHistoryController
                                                      .listHealthCheck[
                                                          patientHistoryController
                                                              .index.value]
                                                      .prescriptions[index]
                                                      .drug
                                                      .drugType
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Dạng thuốc: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: patientHistoryController
                                                      .listHealthCheck[
                                                          patientHistoryController
                                                              .index.value]
                                                      .prescriptions[index]
                                                      .drug
                                                      .drugForm,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Số lượng: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .morningQuantity
                                                          .toString() +
                                                      " " +
                                                      patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .drug
                                                          .drugForm +
                                                      "/buổi",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Ngày: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: DateFormat("dd/MM/yyyy")
                                                          .format(DateTime.parse(
                                                              patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[
                                                                      index]
                                                                  .startDate)) +
                                                      " - " +
                                                      DateFormat("dd/MM/yyyy")
                                                          .format(DateTime.parse(
                                                              patientHistoryController
                                                                  .listHealthCheck[patientHistoryController.index.value]
                                                                  .prescriptions[index]
                                                                  .endDate)),
                                                  style: TextStyle(color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : patientHistoryController.sttDrug.value ==
                                          "afternoon" &&
                                      patientHistoryController
                                              .listHealthCheck[
                                                  patientHistoryController
                                                      .index.value]
                                              .prescriptions[index]
                                              .afternoonQuantity >
                                          0
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 20, 30, 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kWhiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 7,
                                                spreadRadius: 5,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(7, 8)),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'Tên thuốc: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .drug
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'Loại thuốc: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .drug
                                                          .drugType
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'Dạng thuốc: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .drug
                                                          .drugForm,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'Số lượng: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[
                                                                  index]
                                                              .afternoonQuantity
                                                              .toString() +
                                                          " " +
                                                          patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[
                                                                  index]
                                                              .drug
                                                              .drugForm +
                                                          "/buổi",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'Ngày: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                                              patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[
                                                                      index]
                                                                  .startDate)) +
                                                          " - " +
                                                          DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                                              patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController.index.value]
                                                                  .prescriptions[index]
                                                                  .endDate)),
                                                      style: TextStyle(color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : patientHistoryController.sttDrug.value ==
                                              "evening" &&
                                          patientHistoryController
                                                  .listHealthCheck[
                                                      patientHistoryController
                                                          .index.value]
                                                  .prescriptions[index]
                                                  .eveningQuantity >
                                              0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 30),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 20, 30, 20),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: kWhiteColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 7,
                                                    spreadRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(7, 8)),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: 'Tên thuốc: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text: patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[
                                                                  index]
                                                              .drug
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: 'Loại thuốc: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text: patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[
                                                                  index]
                                                              .drug
                                                              .drugType
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: 'Dạng thuốc: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text: patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[
                                                                  index]
                                                              .drug
                                                              .drugForm,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: 'Số lượng: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text: patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[
                                                                      index]
                                                                  .eveningQuantity
                                                                  .toString() +
                                                              " " +
                                                              patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[
                                                                      index]
                                                                  .drug
                                                                  .drugForm +
                                                              "/buổi",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: 'Ngày: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text: DateFormat("dd/MM/yyyy").format(DateTime.parse(patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[
                                                                      index]
                                                                  .startDate)) +
                                                              " - " +
                                                              DateFormat("dd/MM/yyyy").format(DateTime.parse(patientHistoryController
                                                                  .listHealthCheck[
                                                                      patientHistoryController
                                                                          .index
                                                                          .value]
                                                                  .prescriptions[index]
                                                                  .endDate)),
                                                          style: TextStyle(color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          children: [
                            TextSpan(
                                text: 'Hướng dẫn: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: patientHistoryController
                                    .listHealthCheck[
                                        patientHistoryController.index.value]
                                    .prescriptions[0]
                                    .description,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Bạn không có đơn thuốc",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
