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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Triệu chứng: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .symptomHealthChecks
                                      .map((element) {
                                        return element.symptom.name;
                                      })
                                      .toList()
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""),
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Chuẩn đoán: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .healthCheckDiseases
                                      .map((element) {
                                        return element.disease.name;
                                      })
                                      .toList()
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""),
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Ngày uống: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .startDate)) + " - " + DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .endDate)),
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(0.75),
                          2: FlexColumnWidth(0.75)
                        },
                        children: [
                          TableRow(children: [
                            Text(
                              "Tên thuốc",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Đơn vị",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Số lượng",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
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
                            return Column(
                              children: [
                                Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FlexColumnWidth(1.5),
                                    1: FlexColumnWidth(0.75),
                                    2: FlexColumnWidth(0.75)
                                  },
                                  children: [
                                    TableRow(children: [
                                      Text(
                                        patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index]
                                            .drug
                                            .name,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index]
                                            .drug
                                            .drugForm,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        (DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .endDate).difference(DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .startDate)).inDays * patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index].morningQuantity + DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .endDate).difference(DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .startDate)).inDays * patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index].afternoonQuantity + DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .endDate).difference(DateTime.parse(patientHistoryController
                                          .listHealthCheck[
                                              patientHistoryController
                                                  .index.value]
                                          .prescriptions[0]
                                          .startDate)).inDays * patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index].eveningQuantity).toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ]),
                                  ],
                                ),
                                Table(
                                  border: TableBorder.all(),
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Uống: Sáng - " +
                                              patientHistoryController
                                                  .listHealthCheck[
                                                      patientHistoryController
                                                          .index.value]
                                                  .prescriptions[index]
                                                  .morningQuantity
                                                  .toString() +
                                              ", Trưa - " +
                                              patientHistoryController
                                                  .listHealthCheck[
                                                      patientHistoryController
                                                          .index.value]
                                                  .prescriptions[index]
                                                  .afternoonQuantity
                                                  .toString() +
                                              ", Chiều - " +
                                              patientHistoryController
                                                  .listHealthCheck[
                                                      patientHistoryController
                                                          .index.value]
                                                  .prescriptions[index]
                                                  .eveningQuantity
                                                  .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Lời khuyên của bác sĩ: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: patientHistoryController
                                      .listHealthCheck[
                                          patientHistoryController.index.value]
                                      .advice,
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    )
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

// Padding(
                    //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: ListView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: patientHistoryController
                            // .listHealthCheck[
                            //     patientHistoryController.index.value]
                            // .prescriptions
                    //         .length,
                    //     itemBuilder: (BuildContext context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(bottom: 30),
                    //         child: Container(
                    //           padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    //           width: double.infinity,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: kWhiteColor,
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   blurRadius: 7,
                    //                   spreadRadius: 5,
                    //                   color: Colors.grey.withOpacity(0.5),
                    //                   offset: Offset(7, 8)),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               RichText(
                    //                 text: TextSpan(
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   children: [
                    //                     TextSpan(
                    //                         text: 'Tên thuốc: ',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.black)),
                    //                     TextSpan(
                    //                         text: patientHistoryController
                    //                             .listHealthCheck[
                    //                                 patientHistoryController
                    //                                     .index.value]
                    //                             .prescriptions[index]
                    //                             .drug
                    //                             .name,
                    //                         style:
                    //                             TextStyle(color: Colors.black)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 10,
                    //               ),
                    //               RichText(
                    //                 text: TextSpan(
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   children: [
                    //                     TextSpan(
                    //                         text: 'Loại thuốc: ',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.black)),
                    //                     TextSpan(
                    //                         text: patientHistoryController
                    //                             .listHealthCheck[
                    //                                 patientHistoryController
                    //                                     .index.value]
                    //                             .prescriptions[index]
                    //                             .drug
                    //                             .drugType
                    //                             .name,
                    //                         style:
                    //                             TextStyle(color: Colors.black)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 10,
                    //               ),
                    //               RichText(
                    //                 text: TextSpan(
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   children: [
                    //                     TextSpan(
                    //                         text: 'Dạng thuốc: ',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.black)),
                    //                     TextSpan(
                    //                         text: patientHistoryController
                    //                             .listHealthCheck[
                    //                                 patientHistoryController
                    //                                     .index.value]
                    //                             .prescriptions[index]
                    //                             .drug
                    //                             .drugForm,
                    //                         style:
                    //                             TextStyle(color: Colors.black)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 10,
                    //               ),
                    //               RichText(
                    //                 text: TextSpan(
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   children: [
                    //                     TextSpan(
                    //                         text: 'Số lượng: ',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.black)),
                    //                     TextSpan(
                    //                         text: patientHistoryController
                    //                                 .listHealthCheck[
                    //                                     patientHistoryController
                    //                                         .index.value]
                    //                                 .prescriptions[index]
                    //                                 .morningQuantity
                    //                                 .toString() +
                    //                             " " +
                    //                             patientHistoryController
                    //                                 .listHealthCheck[
                    //                                     patientHistoryController
                    //                                         .index.value]
                    //                                 .prescriptions[index]
                    //                                 .drug
                    //                                 .drugForm +
                    //                             "/buổi",
                    //                         style:
                    //                             TextStyle(color: Colors.black)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 10,
                    //               ),
                    //               RichText(
                    //                 text: TextSpan(
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   children: [
                    //                     TextSpan(
                    //                         text: 'Ngày: ',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.black)),
                    //                     TextSpan(
                    //                         text: DateFormat("dd/MM/yyyy").format(
                    //                                 DateTime.parse(patientHistoryController
                    //                                     .listHealthCheck[
                    //                                         patientHistoryController
                    //                                             .index.value]
                    //                                     .prescriptions[index]
                    //                                     .startDate)) +
                    //                             " - " +
                    //                             DateFormat("dd/MM/yyyy").format(
                    //                                 DateTime.parse(
                    //                                     patientHistoryController
                    //                                         .listHealthCheck[
                    //                                             patientHistoryController
                    //                                                 .index
                    //                                                 .value]
                    //                                         .prescriptions[index]
                    //                                         .endDate)),
                    //                         style: TextStyle(color: Colors.black)),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(30),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       style: TextStyle(
                    //         fontSize: 22,
                    //       ),
                    //       children: [
                    //         TextSpan(
                    //             text: 'Hướng dẫn: ',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.black)),
                    //         TextSpan(
                    //             text: patientHistoryController
                    //                 .listHealthCheck[
                    //                     patientHistoryController.index.value]
                    //                 .prescriptions[0]
                    //                 .description,
                    //             style: TextStyle(
                    //                 color: Colors.black, fontSize: 18)),
                    //       ],
                    //     ),
                    //   ),
                    // ),