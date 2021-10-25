import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:telemedicine_mobile/Screens/chatbot_screen.dart';
import 'package:telemedicine_mobile/Screens/components/category.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final patientProfileController = Get.put(PatientProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Hello ' + patientProfileController.patient.value.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: kTitleTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: SvgPicture.asset(
                    "assets/icons/covid-19.svg",
                    height: size.height * 0.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTitleTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildCategoryList(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTitleTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildNewsList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Covid-19\nSymptoms',
            'assets/icons/covid19.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Teeth\nSymptoms',
            'assets/icons/dental_surgeon.png',
            kBlueColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Heart\nSymptoms',
            'assets/icons/heart_surgeon.png',
            kYellowColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Eye\nSymptoms',
            'assets/icons/eye_specialist.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  buildNewsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () async {
              final url =
                  "https://covid19.gov.vn/se-ban-hanh-huong-dan-tiem-vaccine-phong-covid-19-cho-tre-em-tu-12-18-tuoi-171211012064538258.htm";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 225,
                    height: 225,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Từ 1-10/10 cả nước đã tiêm được 11 triệu liều vaccine',
                        style: TextStyle(
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  child: Container(
                    height: 200,
                    width: 200,
                    // decoration: BoxDecoration(
                    //   color: kBlueColor,
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Image.network(
                        'https://covid19.qltns.mediacdn.vn/354844073405468672/2021/10/12/base64-16339610675771824683604-1633995716703-16339957168241470550172.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () async {
              final url =
                  "https://covid19.gov.vn/nguoi-benh-khong-phai-chi-tra-xet-nghiem-covid-19-khi-den-kham-va-dieu-tri-tai-co-so-y-te-cong-lap-171211010234733766.htm";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 225,
                    height: 225,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Người bệnh không phải chi trả xét nghiệm COVID-19',
                        style: TextStyle(
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  child: Container(
                    height: 200,
                    width: 200,
                    // decoration: BoxDecoration(
                    //   color: kBlueColor,
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Image.network(
                        'https://covid19.qltns.mediacdn.vn/354844073405468672/2021/10/10/lay-mau-xet-nghiem-lai-xe-1627307782568392624728-1633884443237-1633884443907258278064.jpeg'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
