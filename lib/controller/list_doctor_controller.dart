import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/call_screen/videocall_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/SymptomHealthCheckPost.dart';

class ListDoctorController extends GetxController {
  RxList<dynamic> listDoctor = [].obs;
  RxInt totalCount = 0.obs;
  RxInt pageSize = 0.obs;
  RxInt totalPage = 0.obs;
  RxInt currentPage = 0.obs;
  RxInt nextPage = 0.obs;
  RxInt? previousPage = 0.obs;
  RxBool isLoading = false.obs;
  Rx<Doctor> doctorDetail = new Doctor(
      id: 0,
      email: "",
      name: "",
      avatar: "",
      practisingCertificate: "",
      certificateCode: "",
      placeOfCertificate: "",
      dateOfCertificate: "",
      scopeOfPractice: "",
      description: "",
      numberOfConsultants: 0,
      rating: 0,
      isVerify: true,
      certificationDoctors: [],
      hospitalDoctors: [],
      majorDoctors: []).obs;

  RxList<dynamic> listSlot = [].obs;

  RxString condition = "".obs;

  Future<bool> getListDoctor({bool isRefresh = false}) async {
    isLoading.value = true;
    if (isRefresh) {
      currentPage.value = 1;
    }
    await FetchAPI.fetchContentDoctorWithCondition(
            condition.value, currentPage.value)
        .then((dataFromServer) {
      if (isRefresh) {
        listDoctor.value = dataFromServer.doctor;
      } else {
        listDoctor.addAll(dataFromServer.doctor);
      }
      totalCount.value = dataFromServer.totalCount;
      pageSize.value = dataFromServer.pageSize;
      totalPage.value = dataFromServer.totalPage;
      currentPage.value = dataFromServer.currentPage;
      nextPage.value = dataFromServer.nextPage;
      previousPage!.value = dataFromServer.previousPage ?? 0;
      isLoading.value = false;
      return true;
    });
    return false;
  }

  RxBool slotAvailable = false.obs;

  getListDoctorSlot(int doctorID) {
    bool flag = true;
    FetchAPI.fetchContentSlot(doctorID).then((dataFromServer) {
      listSlot.clear();
      dataFromServer.map((data) {
        if (DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
                .compareTo(DateTime.parse(data.assignedDate)) <
            0) {
          listSlot.add(data);
        }
        if (DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
                    .compareTo(DateTime.parse(data.assignedDate)) ==
                0 &&
            DateFormat("HH").format(DateTime.now()).compareTo(DateFormat("HH")
                    .format(DateTime.parse("0000-00-00 " + data.startTime))) <=
                0) {
          listSlot.add(data);
        }
      }).toList();

      listSlot.map((element) {
        if (element.healthCheckID < 1) {
          slotAvailable.value = true;
          flag = false;
        }
      }).toList();
      if (flag) {
        slotAvailable.value = false;
      }
    });
  }

  RxList<dynamic> listAllDoctor = [].obs;
  getAllDoctor() {
    FetchAPI.fetchContentAllDoctor().then((dataFromServer) {
      listAllDoctor.value = dataFromServer;
    });
  }

  RxInt healthCheckID = 0.obs;
  int getHealthCheckID(int id) {
    healthCheckID.value = id;
    return healthCheckID.value;
  }

  getDoctorDetailByEmail(String emailDoctor) {
    listAllDoctor.map((e) {
      if (e.email == emailDoctor) doctorDetail.value = e;
    }).toList();
  }

  Rx<Slot> slot = new Slot(
      id: 0,
      assignedDate: "",
      doctorId: 0,
      doctor: new Doctor(
          id: 0,
          email: "",
          name: "",
          avatar: "",
          practisingCertificate: "",
          certificateCode: "",
          placeOfCertificate: "",
          dateOfCertificate: "",
          scopeOfPractice: "",
          description: "",
          numberOfConsultants: 0,
          rating: 0,
          isVerify: true,
          certificationDoctors: [],
          hospitalDoctors: [],
          majorDoctors: []),
      startTime: "",
      endTime: "",
      isActive: true,
      healthCheckID: 0,
      healthCheck: new HealthCheck(
          id: 0,
          height: 0,
          weight: 0,
          reasonCancel: "",
          rating: 0,
          comment: "",
          advice: "",
          token: "",
          patientId: 0,
          createdTime: "",
          canceledTime: "",
          status: "",
          patient: new Patient(
              id: 0,
              email: "",
              name: "",
              avatar: "",
              backgroundDisease: "",
              allergy: "",
              bloodGroup: "",
              isActive: true,
              healthChecks: []),
          healthCheckDiseases: [],
          prescriptions: [],
          slots: [],
          symptomHealthChecks: [])).obs;

  Rx<HealthCheck> healthCheckToken = new HealthCheck(
      id: 0,
      height: 0,
      weight: 0,
      reasonCancel: "",
      rating: 0,
      comment: "",
      advice: "",
      token: "",
      patientId: 0,
      createdTime: "",
      canceledTime: "",
      status: "",
      patient: new Patient(
          id: 0,
          email: "",
          name: "",
          avatar: "",
          backgroundDisease: "",
          allergy: "",
          bloodGroup: "",
          isActive: true,
          healthChecks: []),
      healthCheckDiseases: [],
      prescriptions: [],
      slots: [],
      symptomHealthChecks: []).obs;

  getTokenHealthCheck(int healthCheckID) {
    FetchAPI.joinCall(healthCheckID).then((valueJoinCall) => {
          FetchAPI.getTokenHealthCheck(healthCheckID).then((value) => {
                healthCheckToken.value = value,
                Get.to(CallScreen(
                  uid: valueJoinCall.uid,
                )),
              })
        });
  }

  bookHealthCheck(int height, int weight, Patient patient, Slot slotN,
      List<SymptomHealthCheckPost> symp) {
    HealthCheckPost healthCheckPost = new HealthCheckPost(
        height: height,
        weight: weight,
        patientId: patient.id,
        slotId: slotN.id,
        symptomHealthChecks: symp);

    FetchAPI.createNewHealthCheck(healthCheckPost)
        .then((value) => getListDoctorSlot(slot.value.doctorId));
  }
}
