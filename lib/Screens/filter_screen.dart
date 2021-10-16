import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    filterController.getListTimeFrame();
    filterController.getListSymptom();
    filterController.getListMajor();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          "Tìm kiếm theo",
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
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("Ngày"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 50, 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(260, 8, 0, 0),
                            child: Icon(
                              Icons.calendar_today_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () =>
                                  filterController.pickDate(context),
                              child: Text(
                                filterController.dateSearch.value.year <=
                                            DateTime.now().year &&
                                        filterController
                                                .dateSearch.value.month <=
                                            DateTime.now().month &&
                                        filterController.dateSearch.value.day <
                                            DateTime.now().day
                                    ? ""
                                    : "${filterController.dateSearch.value.day}/${filterController.dateSearch.value.month}/${filterController.dateSearch.value.year}",
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
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("Giờ"),
                ),
              ),
              Wrap(
                spacing: 50.0,
                runSpacing: 3.0,
                children: filterController.listTimeFrame.map((element) {
                  return filterChipWidget(
                      chipName: element.startTime
                              .toString()
                              .replaceRange(5, 8, "") +
                          " - " +
                          element.endTime.toString().replaceRange(5, 8, ""));
                }).toList(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("Triệu chứng"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: MultiSelectDialogField(
                  items: filterController.listSymptomItem,
                  title: Text("Triệu chứng"),
                  selectedColor: kBlueColor,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  buttonText: Text(
                    "Chọn triệu chứng",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onConfirm: (results) {},
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("Chuyên ngành"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: MultiSelectDialogField(
                  items: filterController.listMajorItem,
                  title: Text("Chuyên ngành"),
                  selectedColor: kBlueColor,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  buttonText: Text(
                    "Chọn chuyên ngành",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onConfirm: (results) {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _titleContainer("Tìm gần đây"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Transform.scale(
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
                        )),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(57, 0, 52, 0),
                width: double.infinity,
                height: 100,
                child: filterController.myAddress.value.isEmpty
                    ? Text("")
                    : SingleChildScrollView(
                        child: Text(
                        "Địa chỉ của bạn: " + filterController.myAddress.value,
                        style: TextStyle(fontSize: 20),
                      )),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Get.to(ListDoctorScreen(),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 600)),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(6),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.white70;
                          return kBlueColor; // Defer to the widget's default.
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                ),
              ),
            ],
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
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
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
    );
  }
}
