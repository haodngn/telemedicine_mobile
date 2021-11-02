import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/components/rounded_input_field.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    Key? key,
    this.id,
  }) : super(key: key);
  final String? id;
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackScreen> {
  final TextEditingController FeddbackTextEditingController =
  TextEditingController();
  String star = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mức độ hài lòng của bạn"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: size.width * 0.8,
                color: const Color(0xFFCFE9F1),
                // color: Colors.blueGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);

                          setState(() {
                            star = rating.toString();
                          });
                          print("star: " + star);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RoundedInputField(
                      controller: FeddbackTextEditingController,
                      hintText: "đánh giá",
                      onChanged: (value) {
                        controller:
                        FeddbackTextEditingController;
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        // reqRef.child(widget.id!).update({
                        //   'rating': star,
                        //   'feedback': FeddbackTextEditingController.text,
                        //   'status': 'Đã xử lí xong'
                        // });
                        displayToastMessage("Đánh giá thành công", context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavScreen()));
                      },
                      child: const Text("GỬI ĐÁNH GIÁ"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
