import 'package:flutter/cupertino.dart';

class History {
  late String doctorImage;
  late String doctorName;
  late String doctorNote;
  late String date;
  late String timeStart;
  late String timeEnd;
  late String status;

  History(
      {required this.doctorImage,
      required this.doctorName,
      required this.doctorNote,
      required this.date,
      required this.timeStart,
      required this.timeEnd,
      required this.status});
}
