import 'package:telemedicine_mobile/models/StatisticCovid/Static.dart';

class StatisticCovid {
  late Static internal;
  late Static world;

  StatisticCovid({
    required this.internal,
    required this.world,
  });

  StatisticCovid.fromJson(Map<String, dynamic> json) {
    internal = Static.fromJson(json['internal']);
    world = Static.fromJson(json['world']);
  }
}
