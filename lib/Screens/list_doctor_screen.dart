import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/components/doctor.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class ListDoctorScreen extends StatefulWidget {
  const ListDoctorScreen({Key? key}) : super(key: key);

  @override
  _ListDoctorScreenState createState() => _ListDoctorScreenState();
}

class _ListDoctorScreenState extends State<ListDoctorScreen> {
  final listDoctorController = Get.put(ListDoctorController());

  @override
  void initState() {
    super.initState();
    listDoctorController.getListDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOCTOR LIST LIST"),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(300, 20, 0, 20),
                  child: ElevatedButton(
                    onPressed: () => {
                      Get.to(FilterScreen(),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 600))
                    },
                    child: Icon(Icons.search),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Top Doctors',
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
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: listDoctorController.listDoctor.length,
                      itemBuilder: (BuildContext context, index) {
                        return buildDoctorList(listDoctorController.listDoctor[index]);
                      }),
              ],
            ),
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
