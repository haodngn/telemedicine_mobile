import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine_mobile/controller/address_controller.dart';
import 'package:telemedicine_mobile/controller/hospital_controller.dart';
import 'package:telemedicine_mobile/gg_map_service/DirectionService.dart';
import 'package:telemedicine_mobile/gg_map_service/PlaceService.dart';
import 'package:telemedicine_mobile/gg_map_service/model/Direction.dart';
import 'package:telemedicine_mobile/gg_map_service/model/Place.dart';
import 'package:telemedicine_mobile/models/Hospital.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HospitalMap extends StatefulWidget {
  @override
  _HospitalMap createState() => _HospitalMap();
}

class _HospitalMap extends State<HospitalMap> {
  Completer<GoogleMapController> _controller = Completer();
  HospitalController hospitalController = Get.put(HospitalController());
  final AddressController addressController = Get.put(AddressController());
  final PlacesService placesService = PlacesService();
  bool display = false;
  final TextEditingController _typeAheadController = TextEditingController();
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

  Directions? _info;

  void drawLine(LatLng origin, LatLng destinationLatLng) async {
    setState(() {
      display = true;
    });
    DirectionsRepository()
        .getDirections(origin: origin, destination: destinationLatLng)
        .then((directions) => setState(() => _info = directions));
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(
        getBounds([
          hospitalController.listMarkers.first,
          addressController.origin.value
        ]),
        80.0));
  }

  Marker myLocation = new Marker(
      markerId: new MarkerId("my_location"),
      position: LatLng(10.848425114854084, 106.79768431248772),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: "Vị trí của tôi",
      ));

  redraw(lat, lng) {
    _controller.future.then((value) => {
          value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(lat, lng), zoom: 15)))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => addressController.loading.isTrue
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
                child: Stack(children: <Widget>[
              // Replace this container with your Map widget
              Container(
                child: GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(addressController.location.value.lat,
                            addressController.location.value.lng),
                        zoom: 15),
                    polylines: {
                      if (_info != null)
                        Polyline(
                          polylineId: const PolylineId('overview_polyline'),
                          color: Colors.red,
                          width: 5,
                          points: _info!.polylinePoints
                              .map((e) => LatLng(e.latitude, e.longitude))
                              .toList(),
                        ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      addressController.origin.value,
                      if (display) hospitalController.listMarkers.first
                    }),
              ),
              Positioned(
                top: 10,
                right: 15,
                left: 15,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TypeAheadField<Place>(
                              loadingBuilder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              noItemsFoundBuilder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.description),
                                );
                              },
                              suggestionsCallback: (pattern) async {
                                if (pattern == "")
                                  return List.empty();
                                else
                                  return await placesService.getPlaces(
                                      input: pattern);
                              },
                              onSuggestionSelected: (suggestion) {
                                this._typeAheadController.text =
                                    suggestion.description;
                                addressController.setAddress(
                                    suggestion.description,
                                    suggestion.placeId,
                                    redraw);
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: this._typeAheadController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Colors.red[300],
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: addressController.address.value,
                                    filled: true,
                                    fillColor: Colors.white),
                              ))),
                    ],
                  ),
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
                    ),
                    onPressed: () {
                      drawLine(addressController.origin.value.position,
                          hospitalController.listMarkers.first.position);
                    },
                    child: Text(
                      'TÌM BỆNH VIỆN GẦN ĐÂY',
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
            ])),
          ));
  }
}
