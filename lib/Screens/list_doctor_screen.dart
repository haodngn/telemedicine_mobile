import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/doctor.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';

class ListDoctorScreen extends StatefulWidget {
  const ListDoctorScreen({Key? key}) : super(key: key);

  @override
  _ListDoctorScreenState createState() => _ListDoctorScreenState();
}

class _ListDoctorScreenState extends State<ListDoctorScreen> {
  final listDoctorController = Get.put(ListDoctorController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  FilterController filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    print("aAAa: " + listDoctorController.condition.value);
  }

  Future<bool> getDoctorData({bool isRefresh = false}) async {
    if (!isRefresh) {
      if (listDoctorController.currentPage.value >=
          listDoctorController.totalPage.value) {
        refreshController.loadNoData();
        return true;
      } else {
        listDoctorController.currentPage.value += 1;
      }
    }
    bool isSuccess =
        await listDoctorController.getListDoctor(isRefresh: isRefresh);
    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Danh sách bác sĩ"),
          backgroundColor: kBlueColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Get.to(
                    FilterScreen(
                      filterController: filterController,
                    ),
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 600));
              },
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: Obx(
          () => SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result = await getDoctorData(isRefresh: true);
              if (result) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result = await getDoctorData(isRefresh: false);
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            },
            child: listDoctorController.listDoctor.length == 0 &&
                    listDoctorController.isLoading.value != true
                ? Center(
                    child: Text(
                      "Không tìm thấy bác sĩ phù hợp",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listDoctorController.listDoctor.length,
                    itemBuilder: (BuildContext context, index) {
                      return buildDoctorList(
                          listDoctorController.listDoctor[index]);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  buildDoctorList(Doctor doctor) {
    print(doctor);
    return Container(
      margin: EdgeInsets.only(top: 18),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: DoctorCard(
        doctor,
        doctor.avatar,
        kBlueColor,
      ),
    );
  }
}
