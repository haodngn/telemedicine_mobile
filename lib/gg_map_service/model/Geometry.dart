import 'package:telemedicine_mobile/gg_map_service/model/Location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
