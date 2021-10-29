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
    filterController.majorID.value = 0;
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Danh sách bác sĩ"),
          backgroundColor: kBlueColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Get.to(FilterScreen(),
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 600));
              },
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: Obx(
          () => Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                child: SmartRefresher(
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
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: listDoctorController.listDoctor.length,
                          itemBuilder: (BuildContext context, index) {
                            return buildDoctorList(
                                listDoctorController.listDoctor[index]);
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filterController.listMajor2.map((e) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: InkWell(
                          onTap: () {
                            filterController.majorID.value = e.id;
                            if (filterController.majorID.value == 0) {
                              filterController.searchDoctorByCondition(2);
                            } else {
                              filterController.searchDoctorByCondition(3);
                            }
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: filterController.majorID == e.id
                                  ? kBlueColor
                                  : Color(0xffededed),
                            ),
                            child: Center(
                              child: Text(
                                e.name
                                        .toString()
                                        .replaceAll("Bác sĩ ", "")
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    e.name
                                        .toString()
                                        .replaceAll("Bác sĩ ", "")
                                        .substring(1),
                                style: TextStyle(
                                  color: filterController.majorID == e.id
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDoctorList(Doctor doctor) {
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
