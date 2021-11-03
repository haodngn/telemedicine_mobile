import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine_mobile/controller/hospital_controller.dart';
import 'package:telemedicine_mobile/gg_map_service/GeoService.dart';
import 'package:telemedicine_mobile/gg_map_service/PlaceService.dart';
import 'package:telemedicine_mobile/gg_map_service/model/Location.dart';
import 'package:telemedicine_mobile/gg_map_service/model/PlaceSearch.dart';

class AddressController extends GetxController {
  RxBool loading = false.obs;
  Rx<Location> location = new Location(lat: 0.0, lng: 0.0).obs;
  RxString address = "".obs;
  Rx<Marker> origin = new Marker(markerId: new MarkerId("origin")).obs;
  HospitalController controller = Get.put(HospitalController());

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  void setAddress(String addressString, String placeId, Function redraw) async {
    try {
      PlaceSearch placeSearch = await PlacesService().getPlace(placeId);
      address.value = addressString;
      location.value = new Location(
        lat: placeSearch.geometry.location.getLat,
        lng: placeSearch.geometry.location.getLng,
      );
      controller.getNearHospital(placeSearch.geometry.location.getLat,
          placeSearch.geometry.location.getLng);
      origin.value = new Marker(
          markerId: new MarkerId("origin"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(placeSearch.geometry.location.getLat,
              placeSearch.geometry.location.getLng));
      update();
    } on Exception catch (_) {} finally {
      new Future.delayed(const Duration(milliseconds: 1000),
          () => {redraw(location.value.lat, location.value.lng)});
    }
  }

  void getLocation() async {
    loading.value = true;
    try {
      var positionResponse = await getCurrentLocation();
      location.value.lat = positionResponse.latitude;
      location.value.lng = positionResponse.longitude;
      origin.value = new Marker(
          markerId: new MarkerId("origin"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(location.value.lat, location.value.lng));
      var addressResponse = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(location.value.lat, location.value.lng));
      address.value = addressResponse.first.addressLine;
    } on Exception catch (_) {} finally {
      loading.value = false;
    }
  }
}
