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
                                patientHistoryController.sttHistory.value =
                                    "upcoming"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "upcoming"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Sáng",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttHistory.value ==
                                            "upcoming"
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
                                patientHistoryController.sttHistory.value =
                                    "complete"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "complete"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Trưa",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttHistory.value ==
                                            "complete"
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
                                patientHistoryController.sttHistory.value =
                                    "cancel"
                              },
                              child: Container(
                                width: 104,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: patientHistoryController
                                              .sttHistory.value ==
                                          "cancel"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                                ),
                                child: Center(
                                    child: Text(
                                  "Chiều",
                                  style: TextStyle(
                                    color: patientHistoryController
                                                .sttHistory.value ==
                                            "cancel"
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
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sáng",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1.5),
                                2: FlexColumnWidth(.5)
                              },
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Tên thuốc",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Ngày",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Số lượng",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            border: TableBorder.all(),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(.5)
                            },
                            children: patientHistoryController.listPrescriptions
                                .map((pres) {
                              return TableRow(children: [
                                Text(
                                  pres.drug.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(pres.startDate)) +
                                      "-" +
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(pres.endDate)),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  pres.morningQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Trưa",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1.5),
                                2: FlexColumnWidth(.5)
                              },
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Tên thuốc",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Ngày",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Số lượng",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            border: TableBorder.all(),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(.5)
                            },
                            children: patientHistoryController.listPrescriptions
                                .map((pres) {
                              return TableRow(children: [
                                Text(
                                  pres.drug.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(pres.startDate)) +
                                      "-" +
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(pres.endDate)),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  pres.afternoonQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Chiều",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1.5),
                                2: FlexColumnWidth(.5)
                              },
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Tên thuốc",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Ngày",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Số lượng",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            border: TableBorder.all(),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(.5)
                            },
                            children: patientHistoryController.listPrescriptions
                                .map((pres) {
                              return TableRow(children: [
                                Text(
                                  pres.drug.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(pres.startDate)) +
                                      "-" +
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(pres.endDate)),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  pres.eveningQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Hướng dẫn:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ],
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
