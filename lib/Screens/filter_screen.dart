import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  TextEditingController textNameDoctorController = TextEditingController();
  final filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
    textNameDoctorController.text = filterController.nameDoctor.value;
    _controller3 = TextEditingController(text: '00:00');
    _controller4 = TextEditingController(text: '00:00');
    _getValue();
    filterController.getListHospital();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _controller3.text = filterController.startTime.value;
        _controller4.text = filterController.endTime.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          "Tìm kiếm bác sĩ theo:",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: _oFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _titleContainer("Tên bác sĩ:"),
                    ),
                  ),
                  TextFormField(
                    controller: textNameDoctorController,
                    onChanged: (val) => filterController.nameDoctor.value = val,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: _titleContainer("Ngày:"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                child: Icon(
                                  Icons.calendar_today_rounded,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () =>
                                    filterController.pickDate(context),
                                child: Text(
                                  "${filterController.dateSearch.value.day}/${filterController.dateSearch.value.month}/${filterController.dateSearch.value.year}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: _titleContainer("Khoảng thời gian:"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DateTimePicker(
                      type: DateTimePickerType.time,
                      timePickerEntryModeInput: true,
                      controller: _controller3,
                      // initialValue: '',
                      icon: Icon(Icons.access_time),
                      timeLabelText: "Thời gian bắt đầu:",
                      use24HourFormat: true,
                      locale: Locale('pt', 'BR'),
                      onChanged: (val) =>
                          filterController.startTime.value = val,
                      validator: (val) {
                        filterController.startTime.value = val ?? '';
                        return null;
                      },
                      onSaved: (val) => {
                        filterController.startTime.value = val!,
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DateTimePicker(
                      type: DateTimePickerType.time,
                      timePickerEntryModeInput: true,
                      controller: _controller4,
                      // initialValue: '',
                      icon: Icon(Icons.access_time),
                      timeLabelText: "Thời gian kết thúc:",
                      use24HourFormat: true,
                      locale: Locale('pt', 'BR'),
                      onChanged: (val) => filterController.endTime.value = val,
                      validator: (val) {
                        filterController.endTime.value = val ?? '';
                        return null;
                      },
                      onSaved: (val) => (val) => {
                            filterController.endTime.value = val!,
                            print(val),
                          },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: _titleContainer("Chuyên khoa:"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MultiSelectDialogField(
                      initialValue: filterController.listResultMajor,
                      items: filterController.listMajorItem,
                      title: Text("Chuyên khoa"),
                      selectedColor: kBlueColor,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      buttonText: Text(
                        "Chọn chuyên khoa",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onConfirm: (results) {
                        filterController.listResultMajor.value = results;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: _titleContainer("Bệnh viện:"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MultiSelectDialogField(
                      initialValue: filterController.listResultHospital,
                      items: filterController.listHospitalItem,
                      title: Text("Bệnh viện"),
                      selectedColor: kBlueColor,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      buttonText: Text(
                        "Chọn bệnh viện",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onConfirm: (results) {
                        filterController.listResultHospital.value = results;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                        child: _titleContainer("Tìm gần đây:"),
                      ),
                      Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            activeColor: kBlueColor,
                            value: filterController.searchByLocation.value,
                            onChanged: (bool val) {
                              if (filterController.searchByLocation.value) {
                                filterController.searchByLocation.value = false;
                                filterController.myAddress.value = "";
                              } else {
                                filterController.getMyAddress();
                              }
                            },
                          ))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(57, 0, 57, 0),
                    width: double.infinity,
                    height: 100,
                    child: filterController.myAddress.value.isEmpty
                        ? Text("")
                        : SingleChildScrollView(
                            child: Text(
                            "Địa chỉ của bạn: " +
                                filterController.myAddress.value,
                            style: TextStyle(fontSize: 20),
                          )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => {
                              filterController.searchDoctorByCondition(1),
                              Get.back(),
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(6),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.white70;
                                return kBlueColor; // Defer to the widget's default.
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                            ),
                            child: Text(
                              "Tìm",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => {
                              filterController.searchDoctorByCondition(2),
                              Get.back(),
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(6),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.white70;
                                return kGreenLightColor; // Defer to the widget's default.
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                            ),
                            child: Text(
                              "Tìm tất cả",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
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

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
  );
}

// class filterChipWidget extends StatefulWidget {
//   final String chipName;
//
//   filterChipWidget({Key? key, required this.chipName}) : super(key: key);
//
//   @override
//   _filterChipWidgetState createState() => _filterChipWidgetState();
// }
//
// class _filterChipWidgetState extends State<filterChipWidget> {
//   var _isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return FilterChip(
//       label: Text(widget.chipName),
//       labelStyle: TextStyle(
//           color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
//       selected: _isSelected,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       backgroundColor: Color(0xffededed),
//       onSelected: (isSelected) {
//         setState(() {
//           _isSelected = isSelected;
//         });
//       },
//       selectedColor: kBlueColor,
//     );
//   }
// }
