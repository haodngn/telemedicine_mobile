import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/doctor.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: Text("Danh sách bác sĩ"),
          backgroundColor: kBlueColor,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: kBackgroundColor,
        body: Obx(
          () => Column(
            crossAxisAlignment: listDoctorController.isLoading.value
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment: listDoctorController.isLoading.value
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(300, 20, 0, 20),
                child: ElevatedButton(
                  onPressed: () => {
                    Get.to(
                        FilterScreen(
                          filterController: filterController,
                        ),
                        transition: Transition.downToUp,
                        duration: Duration(milliseconds: 600))
                  },
                  child: Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
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
                  child: listDoctorController.listDoctor.length == 0
                      ? Center(
                          child: Text(
                            "Không tìm thấy bác sĩ phù hợp",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listDoctorController.listDoctor.length,
                          itemBuilder: (BuildContext context, index) {
                            return buildDoctorList(
                                listDoctorController.listDoctor[index]);
                          }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDoctorList(doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            doctor,
            doctor.avatar,
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
