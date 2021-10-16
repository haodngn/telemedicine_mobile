import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:telemedicine_mobile/constant.dart';

class ConsultationRatingScreen extends StatefulWidget {
  const ConsultationRatingScreen({Key? key}) : super(key: key);

  @override
  _ConsultationRatingScreenState createState() => _ConsultationRatingScreenState();
}

class _ConsultationRatingScreenState extends State<ConsultationRatingScreen> {
  double _initialRating = 0.0;
  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: kBlueColor,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/images/doctor1.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Text(
                        "Danh Phạm",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  child: Text(
                    "Chúc bạn và gia đình luôn luôn khỏe mạnh",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25),
                child: RatingBar.builder(
                  initialRating: _initialRating,
                  minRating: 1,
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 50.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {});
                  },
                  updateOnDrag: true,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 220,
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nhập đánh giá của bạn...',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, bottom: 10, right: 30, top: 10),
                    height: 80,
                    width: double.infinity,
                    color: Colors.white,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(6),
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.white70;
                              return kBlueColor; // Defer to the widget's default.
                            }),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Gửi',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}