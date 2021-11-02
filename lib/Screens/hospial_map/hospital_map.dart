import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine_mobile/controller/hospital_controller.dart';

class HospitalMap extends StatefulWidget {
  @override
  _HospitalMap createState() => _HospitalMap();
}

class _HospitalMap extends State<HospitalMap> {
  Completer<GoogleMapController> _controller = Completer();
  HospitalController hospitalController = Get.put(HospitalController());
  LatLngBounds getBounds(List<Marker> markers) {
    var lngs = markers.map<double>((m) => m.position.longitude).toList();
    var lats = markers.map<double>((m) => m.position.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  Marker myLocation = new Marker(
      markerId: new MarkerId("my_location"),
      position: LatLng(10.848425114854084, 106.79768431248772),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: "Vị trí của tôi",
      ));

  void drawLine() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {});
    controller.animateCamera(CameraUpdate.newLatLngBounds(
        getBounds([hospitalController.listMarkers.first, myLocation]), 80.0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      // Replace this container with your Map widget
      Container(
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(10.848425114854084, 106.79768431248772), zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: hospitalController.listMarkers.isEmpty
              ? {
                  myLocation,
                }
              : hospitalController.listMarkers.toSet(),
        ),
      ),
      Positioned(
          bottom: 20,
          left: 15,
          right: 15,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,
                    40), // double.infinity is the width and 30 is the height
                primary: Color(0xFFF9AA33),
                onPrimary: Colors.black),
            onPressed: () {
              drawLine();
            },
            child: Text(
              'TÌM BỆNH VIỆN GẦN ĐÂY',
              style: TextStyle(fontSize: 16),
            ),
          ))
    ]));
  }
}
