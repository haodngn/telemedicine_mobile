import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  var doctor;
  var image;
  var _bgColor;

  IconData? _selectedIcon;

  DoctorCard(this.doctor, this.image, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(doctor.name, doctor.scopeOfPractice, doctor.description, image, doctor.majorDoctors, doctor.hospitalDoctors, doctor.certificationDoctors),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: Image.network(doctor.avatar,
                  errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/default_avatar.png"),
                ),
                title: Text(
                  doctor.majorDoctors.length.toString(),
                  style: TextStyle(
                    color: kTitleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  doctor.scopeOfPractice,
                  style: TextStyle(
                    color: kTitleTextColor.withOpacity(0.7),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 0, 5),
                child: Text("Số lượng cuộc hẹn: " + doctor.numberOfConsultants.toString()),
              ),
              Container(
                width: 160,
                child: RatingBar.builder(
                  initialRating: doctor.rating + .0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 20.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //setState(() {});
                  },
                  updateOnDrag: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
