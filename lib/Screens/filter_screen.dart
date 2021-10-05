import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late DateTime dob = DateTime.now().subtract(Duration(days: 1));

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year),
        lastDate: DateTime(initialDate.year + 50));

    if (newDate == null) return;

    setState(() {
      dob = newDate as DateTime;
    });
  }

  List problemList = [
    "Fever or chills",
    "Cough",
    "Shortness of breath or difficulty breathing",
    "Fatigue",
    "Muscle or body aches",
    "Headache",
    "New loss of taste or smell",
    "Sore throat",
    "Congestion or runny nose",
    "Nausea or vomiting",
    "Diarrhea",
    "Other",
  ];

  String problemChoose = "Other";

  List speciaLists = [
    "Dermatologists",
    "Infectious disease doctors",
    "Ophthalmologists",
    "Obstetrician/gynecologists",
    "Cardiologists",
    "Endocrinologists",
    "Gastroenterologists",
    "Other",
  ];

  String specialistChoose = "Other";

  var myLocation = "";
  bool searchByLocation = false;

  void getMyLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
  }

  String myAddress = "";

  void getMyAddress() async {
    final coordinates = new Coordinates(12.982030, 77.593540);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      myAddress = addresses.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          "Search by",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Date"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(320, 8, 0, 0),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => pickDate(context),
                            child: Text(
                              dob.year <= DateTime.now().year &&
                                      dob.month <= DateTime.now().month &&
                                      dob.day < DateTime.now().day
                                  ? ""
                                  : "${dob.day}/${dob.month}/${dob.year}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Time"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    child: Wrap(
                  spacing: 50.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    filterChipWidget(chipName: '07:00 - 08:30'),
                    filterChipWidget(chipName: '08:45 - 10:15'),
                    filterChipWidget(chipName: '10:30 - 12:00'),
                    filterChipWidget(chipName: '12:30 - 02:00'),
                    filterChipWidget(chipName: '02:15 - 03:45'),
                    filterChipWidget(chipName: '04:00 - 05:30'),
                  ],
                )),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Problems"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButton(
                      onChanged: (newValue) {
                        setState(() {
                          problemChoose = newValue.toString();
                        });
                      },
                      value: problemChoose,
                      isExpanded: true,
                      items: problemList.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              valueItem,
                              style: TextStyle(
                                  color: Colors.black,
                                  //Color(0xff6200ee),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Specialists"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButton(
                      onChanged: (newValue) {
                        setState(() {
                          specialistChoose = newValue.toString();
                        });
                      },
                      value: specialistChoose,
                      isExpanded: true,
                      items: speciaLists.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              valueItem,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("Find nearby"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeColor: kBlueColor,
                        value: searchByLocation,
                        onChanged: (bool val) {
                          setState(() {
                            if (searchByLocation) {
                              searchByLocation = false;
                              setState(() {
                                myAddress = "";
                              });
                            }
                            else {
                              searchByLocation = true;
                              getMyAddress();
                            }
                          });
                        },
                      )),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(57, 0, 52, 0),
                child: Container(
                  width: 500,
                  height: 60,
                  child: myAddress.isEmpty
                      ? Text("")
                      : SingleChildScrollView(
                          child: Text("Your address: " + myAddress, style: TextStyle(fontSize: 15),)),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Container(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () => {getMyLocation()},
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
                    "Search",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Colors.black,
          //Color(0xff6200ee),
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: kBlueColor,
      //Color(0xffeadffd),
    );
  }
}
