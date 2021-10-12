import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/models/Province.dart';

class FetchAddressAPI {

  static Future<List<Province>> fetchProvinces({int page = 1}) async {
    Map<String, String> qParams = {
      'param1': 'one',
      'param2': 'two',
    };


    final response = await http.get(
        Uri.parse("https://provinces.open-api.vn/api/?depth=3"),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var list = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      List<Province> provinces = list.map((e) => Province.fromJson(e)).toList();
      return provinces;
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else {
      throw Exception("Can\'t get province");
    }
  }
}