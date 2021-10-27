import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/components/schedule.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class BookConsultationScreen extends StatefulWidget {
  const BookConsultationScreen({Key? key}) : super(key: key);

  @override
  _BookConsultationScreenState createState() => _BookConsultationScreenState();
}

class _BookConsultationScreenState extends State<BookConsultationScreen> {
  final listDoctorController = Get.put(ListDoctorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Đặt lịch tư vấn"),
          backgroundColor: kBlueColor,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listDoctorController.listSlot.length,
                  itemBuilder: (BuildContext context, index) {
                    return listDoctorController.listSlot[index].healthCheckID <
                            1
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ScheduleCard(
                              'Buổi tư vấn',
                              DateFormat('EEEE').format(DateTime.parse(
                                      listDoctorController
                                          .listSlot[index].assignedDate)) +
                                  ' . ' +
                                  listDoctorController.listSlot[index].startTime
                                      .toString()
                                      .replaceRange(5, 8, "") +
                                  " - " +
                                  listDoctorController.listSlot[index].endTime
                                      .toString()
                                      .replaceRange(5, 8, ""),
                              DateFormat('dd').format(DateTime.parse(
                                  listDoctorController
                                      .listSlot[index].assignedDate)),
                              DateFormat('MMM').format(DateTime.parse(
                                  listDoctorController
                                      .listSlot[index].assignedDate)),
                              index % 3 == 0
                                  ? kOrangeColor
                                  : index % 2 == 0
                                      ? kYellowColor
                                      : kBlueColor,
                              listDoctorController
                                  .listSlot[index].healthCheckID,
                              listDoctorController
                                  .listSlot[index].healthCheck.patient.email,
                              listDoctorController.listSlot[index],
                              true,
                            ),
                          )
                        : Container();
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
