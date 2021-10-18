import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';

class ViewDrugScreen extends StatefulWidget {
  const ViewDrugScreen({Key? key}) : super(key: key);

  @override
  _ViewDrugScreenState createState() => _ViewDrugScreenState();
}

class _ViewDrugScreenState extends State<ViewDrugScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Morning",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          "Drug Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: Text(
                          "Units",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index) {
                        return BoxDrug();
                      }),
                  Text(
                    "Afternoon",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          "Drug Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: Text(
                          "Units",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index) {
                        return BoxDrug();
                      }),

                  Text(
                    "Evening",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          "Drug Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: Text(
                          "Units",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, index) {
                          return BoxDrug(
                              );
                        }),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 20),
                    child: TextField(
                      readOnly: true,
                      maxLines: 5,
                      // controller: textBackgroundDiseaseController,
                      decoration: InputDecoration(
                        hintText: "Remember to take your medicine",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BoxDrug extends StatelessWidget {
  // final String doctorImage;
  // final String doctorName;
  // final String doctorNote;
  // final String date;
  // final String sameDate;
  // final String timeStart;
  // final String timeEnd;
  // final String status;
  //
  // BoxDrug({
  //   required this.doctorImage,
  //   required this.doctorName,
  //   required this.doctorNote,
  //   required this.date,
  //   required this.sameDate,
  //   required this.timeStart,
  //   required this.timeEnd,
  //   required this.status,
  // });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              "Acenocoumarol",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: 100,
            child: Text(
              "10",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: 50,
            child: Text(
              "pills",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
