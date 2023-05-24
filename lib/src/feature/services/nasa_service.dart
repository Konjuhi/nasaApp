import 'dart:convert';

import 'package:expunivers/src/feature/models/mars_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../global/enviroment/config.dart';

class ResultNasaService {
  static Future<MarsModel> getMyResultOfNasaService() async {
    var request = await http.get(
      Uri.parse(ApiConfig.getMyResultOfNasa),
    );

    final response = jsonDecode(request.body);
    if (kDebugMode) {
      print(response.toString());
    }
    return MarsModel.fromJson(response);
  }
}
