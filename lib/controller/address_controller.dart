import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:telemedicine_mobile/models/City.dart';
import 'package:http/http.dart' as http;

class GetAddress {
  static const String url = "https://provinces.open-api.vn/api/";

  static List<City> parseAddress(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<City> cities = list.map((model) => City.fromJSon(model)).toList();
    return cities;
  }

  static Future<List<City>> fetchCities({int page = 1}) async {
    final response = await http.get(Uri.parse("$url"));
    if(response.statusCode == 200) {
      return compute(parseAddress, response.body);
    } else if(response.statusCode == 404) {
      throw Exception("Not found aaaaaaaaaaaaa");
    } else {
      throw Exception("Can\'t get city");
    }
  }
}
