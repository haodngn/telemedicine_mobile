import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/News.dart';

import '../constant.dart';
import 'home_screen.dart';

class Covid19 extends StatefulWidget {
  Covid19({Key? key}) : super(key: key);

  @override
  _Covid19State createState() => _Covid19State();
}

class _Covid19State extends State<Covid19> {
  NumberFormat formatter = NumberFormat('###,000');
  var statisticCovid;
  List<News>? listNews;

  PatientProfileController patientProfileController =
      Get.put(PatientProfileController());
  void getStatisticCovid() async {
    statisticCovid = await FetchAPI.fetchContentStaticCovid();
  }

  void getNews() async {
    var newsList = await FetchAPI.fetchContentNews();
    print(newsList.length);
    setState(() {
      listNews = newsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
    getStatisticCovid();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("MetaCine"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
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
                      Expanded(
                        child: InkWell(
                          onTap: () => {
                            patientProfileController.statusCovid.value =
                                "VietNam",
                          },
                          child: Container(
                            width: 104,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  patientProfileController.statusCovid.value ==
                                          "VietNam"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                            ),
                            child: Center(
                                child: Text(
                              "Việt Nam",
                              style: TextStyle(
                                color: patientProfileController
                                            .statusCovid.value ==
                                        "VietNam"
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => {
                            patientProfileController.statusCovid.value = "World"
                          },
                          child: Container(
                            width: 104,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  patientProfileController.statusCovid.value ==
                                          "World"
                                      ? kBlueColor
                                      : Color(0xfff6f6f6),
                            ),
                            child: Center(
                                child: Text(
                              "Thế giới",
                              style: TextStyle(
                                color: patientProfileController
                                            .statusCovid.value ==
                                        "World"
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              statisticCovid != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                color: Color(0xffed1c24).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Center(
                                    child: Text(
                                      "Số ca nhiễm".toUpperCase(),
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    patientProfileController
                                                .statusCovid.value ==
                                            "VietNam"
                                        ? formatter
                                            .format(statisticCovid['total']
                                                .internal
                                                .cases)
                                            .replaceAll(",", ".")
                                        : NumberFormat.compact()
                                            .format(statisticCovid['total']
                                                .world
                                                .cases)
                                            .toString(),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xffED1C24),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Hôm nay",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "+${patientProfileController.statusCovid.value == "VietNam" ? statisticCovid['today'].internal.cases > 100 ? formatter.format(statisticCovid['today'].internal.cases).replaceAll(",", ".") : statisticCovid['today'].internal.cases : statisticCovid['today'].world.cases > 100 ? formatter.format(statisticCovid['today'].world.cases).replaceAll(",", ".") : statisticCovid['today'].world.cases}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                color: Color(0xff3ca745).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Khỏi".toUpperCase(),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    patientProfileController
                                                .statusCovid.value ==
                                            "VietNam"
                                        ? formatter
                                            .format(statisticCovid['total']
                                                .internal
                                                .treating)
                                            .replaceAll(",", ".")
                                        : NumberFormat.compact()
                                            .format(statisticCovid['total']
                                                .world
                                                .treating)
                                            .replaceAll(",", "."),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff28A745),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Hôm nay",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "+${patientProfileController.statusCovid.value == "VietNam" ? statisticCovid['today'].internal.treating > 100 ? formatter.format(statisticCovid['today'].internal.treating).replaceAll(",", ".") : statisticCovid['today'].internal.treating : statisticCovid['today'].world.treating > 100 ? formatter.format(statisticCovid['today'].world.treating).replaceAll(",", ".") : statisticCovid['today'].world.treating}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                color: Color(0xffF0EFF4),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Tử vong".toUpperCase(),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    patientProfileController
                                                .statusCovid.value ==
                                            "VietNam"
                                        ? formatter
                                            .format(statisticCovid['total']
                                                .internal
                                                .death)
                                            .replaceAll(",", ".")
                                        : NumberFormat.compact()
                                            .format(statisticCovid['total']
                                                .world
                                                .death)
                                            .replaceAll(",", "."),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Hôm nay",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "+${patientProfileController.statusCovid.value == "VietNam" ? statisticCovid['today'].internal.death > 100 ? formatter.format(statisticCovid['today'].internal.death).replaceAll(",", ".") : statisticCovid['today'].internal.death : statisticCovid['today'].world.death > 100 ? formatter.format(statisticCovid['today'].world.death).replaceAll(",", ".") : statisticCovid['today'].world.death}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Text(
                      'Tin tức',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTitleTextColor,
                        fontSize: 18,
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Xem tất cả",
                        style: TextStyle(
                          fontSize: 16,
                          color: kBlueColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              listNews != null
                  ? Column(
                      children: [
                        ...listNews!.map((e) => BuildNewsList(
                            title: e.title,
                            desc: e.description,
                            url: e.url,
                            urlImage: e.urlToImage))
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
