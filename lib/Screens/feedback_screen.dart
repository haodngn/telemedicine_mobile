import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    Key? key,
    this.id,
  }) : super(key: key);
  final int? id;
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackScreen> {
  final listDoctorController = Get.put(ListDoctorController());
  final patientHistoryController = Get.put(PatientHistoryController());
  final TextEditingController FeddbackTextEditingController =
      TextEditingController();
  late int rating = 3;
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mức độ hài lòng của bạn"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đánh giá của bạn",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Bạn cảm thấy thế nào?",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: RatingBar.builder(
                      onRatingUpdate: (ratingValue) {
                        rating = ratingValue.round();
                      },
                      initialRating: rating + 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemSize: 60.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Bình luận của bạn",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: comment,
                  decoration: InputDecoration(
                    errorText: patientHistoryController.emptyComment.value
                        ? "Vui lòng nhập bình luận"
                        : null,
                    errorStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    hintText: "Bình luận của bạn",
                  ),
                  maxLines: 10,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      FocusScope.of(context).unfocus(),
                      patientHistoryController.editHealthCheckInfo(
                          rating,
                          comment.text,
                          listDoctorController.healthCheckToken.value,
                          0,
                          0),
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 2000),
                                () {
                              Navigator.of(context).pop();
                              Get.to(BottomNavScreen());
                            });
                            return AlertDialog(
                                content: Container(
                              height: 110,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 80,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Hoàn thành cuộc hẹn",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ));
                          }),
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.white70;
                        return kBlueColor; // Defer to the widget's default.
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                    ),
                    child: Text(
                      "Gửi đánh giá",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
