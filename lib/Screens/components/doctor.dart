import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';

class DoctorCard extends StatelessWidget {
  Doctor doctor;
  var image;
  var _bgColor;

  IconData? _selectedIcon;

  DoctorCard(this.doctor, this.image, this._bgColor);
  final listDoctorController = Get.put(ListDoctorController());
  final patientProfileController = Get.put(PatientProfileController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.0),
      onTap: () {
        listDoctorController.getListDoctorSlot(doctor.id);
        patientProfileController.getMyPatient();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              doctor.name,
              doctor.scopeOfPractice,
              doctor.description,
              image,
              doctor.majorDoctors,
              doctor.hospitalDoctors,
              doctor.certificationDoctors,
              doctor.rating,
              doctor.numberOfConsultants,
              doctor.dateOfCertificate,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: kBlueLightColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10),
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: Image.network(
                    doctor.avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/default_avatar.png"),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bs." + doctor.name,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTitleTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2.2,
                      ),
                    ),
                    Text(
                      doctor.scopeOfPractice,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTitleTextColor.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: kYellowColor.withOpacity(0.8)),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          doctor.rating != 0
                              ? doctor.rating.toStringAsFixed(1)
                              : "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "( ${doctor.numberOfConsultants != 0 ? doctor.numberOfConsultants.toStringAsFixed(0) : "0"} lượt tư vấn )",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTitleTextColor.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
