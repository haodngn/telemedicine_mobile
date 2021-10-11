import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientHistoryController extends GetxController {

  static DateTime date = DateTime.parse("2021-10-06");
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);

  static DateTime timeStart = DateTime.parse("20210710 13:27:00");
  String formattedTimeStart = DateFormat('HH:mm:ss').format(timeStart);

  static DateTime timeEnd = DateTime.parse("20210710 14:27:00");
  String formattedTimeEnd = DateFormat('HH:mm:ss').format(timeEnd);

}
