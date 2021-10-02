import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textStreetAddressController = TextEditingController();
  TextEditingController textLocalityController = TextEditingController();
  TextEditingController textCityController = TextEditingController();
  TextEditingController textPostalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var selectedRadio;

  setSelectedRadio(var value) {
    setState(() {
      selectedRadio = value;
    });
  }

  late DateTime dob = DateTime.now();

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.parse("1990-01-01");
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(initialDate.year + 30));

    if (newDate == null) return;

    setState(() {
      dob = newDate as DateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to the",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  Text(
                    "Counselor App",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30),
                  ),
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                        child: Text(
                          "Name:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 0, 140, 0),
                        child: TextField(
                          controller: textFirstNameController,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                        child: TextField(
                          controller: textLastNameController,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                        child: Text(
                          "Gender:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 5, 0, 0),
                        child: Radio(
                          value: "Male",
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setSelectedRadio(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(120, 18, 0, 0),
                        child: Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(220, 5, 0, 0),
                        child: Radio(
                          value: "Female",
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setSelectedRadio(value);
                            //setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(260, 18, 0, 0),
                        child: Text(
                          "Female",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                        child: Text(
                          "DOB:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(294, 8, 0, 0),
                        child: Icon(
                          Icons.calendar_today_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => pickDate(context),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 123),
                              child: Text(
                                dob.year >= DateTime.now().year &&
                                        dob.month >= DateTime.now().month &&
                                        dob.day >= DateTime.now().day
                                    ? ""
                                    : "${dob.day}/${dob.month}/${dob.year}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                        child: Text(
                          "Phone:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: TextField(
                          controller: textPhoneController,
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                        child: Text(
                          "Email:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: TextField(
                          controller: textEmailController,
                          decoration: InputDecoration(
                            hintText: "Your Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Address:",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 60, 180, 0),
                        child: TextField(
                          controller: textStreetAddressController,
                          decoration: InputDecoration(
                            hintText: "Street Address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(180, 60, 0, 0),
                        child: TextField(
                          controller: textLocalityController,
                          decoration: InputDecoration(
                            hintText: "Locality",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 140, 180, 0),
                        child: TextField(
                          controller: textCityController,
                          decoration: InputDecoration(
                            hintText: "City",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(180, 140, 0, 0),
                        child: TextField(
                          controller: textPostalCodeController,
                          decoration: InputDecoration(
                            hintText: "Postal Code",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(240, 20, 0, 0),
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      onPressed: () => Get.to(BottomNavScreen()),
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
