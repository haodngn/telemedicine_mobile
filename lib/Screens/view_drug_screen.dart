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
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Container(
                          width: double.infinity,
                          child: Text(
                            "Đơn thuốc: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: MediaQuery.of(context).size.width * 0.5 - 7,
                            height: 30,
                            child: Center(
                              child: Text(
                                "Tên thuốc",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.25 - 7,
                            child: Center(
                              child: Text(
                                "Số lượng",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.25 - 7,
                            child: Center(
                              child: Text(
                                "Đơn vị",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                Row(
                                  children: [
                                    Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          7,
                                      height: 60,
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Text(
                                        patientHistoryController
                                            .listHealthCheck[
                                                patientHistoryController
                                                    .index.value]
                                            .prescriptions[index]
                                            .drug
                                            .name,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                              0.25 -
                                          7,
                                      child: Center(
                                        child: Text(
                                          (DateTime.parse(patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].endDate).difference(DateTime.parse(patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].startDate)).inDays *
                                                      patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .morningQuantity +
                                                  DateTime.parse(patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].endDate).difference(DateTime.parse(patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].startDate)).inDays *
                                                      patientHistoryController
                                                          .listHealthCheck[
                                                              patientHistoryController
                                                                  .index.value]
                                                          .prescriptions[index]
                                                          .afternoonQuantity +
                                                  DateTime.parse(patientHistoryController
                                                              .listHealthCheck[
                                                                  patientHistoryController
                                                                      .index
                                                                      .value]
                                                              .prescriptions[index]
                                                              .endDate)
                                                          .difference(DateTime.parse(patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].startDate))
                                                          .inDays *
                                                      patientHistoryController.listHealthCheck[patientHistoryController.index.value].prescriptions[index].eveningQuantity)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                              0.25 -
                                          7,
                                      child: Center(
                                        child: Text(
                                          patientHistoryController
                                              .listHealthCheck[
                                                  patientHistoryController
                                                      .index.value]
                                              .prescriptions[index]
                                              .drug
                                              .drugForm,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width -22,
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
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
                                      Text(
                                        "Ngày uống: " +
                                            DateFormat("dd/MM/yyyy").format(
                                                DateTime.parse(
                                                    patientHistoryController
                                                        .listHealthCheck[
                                                            patientHistoryController
                                                                .index.value]
                                                        .prescriptions[index]
                                                        .startDate)) +
                                            " - " +
                                            DateFormat("dd/MM/yyyy").format(
                                                DateTime.parse(
                                                    patientHistoryController
                                                        .listHealthCheck[
                                                            patientHistoryController
                                                                .index.value]
                                                        .prescriptions[index]
                                                        .endDate)),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
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
