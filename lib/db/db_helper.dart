import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inter2grow_qoute_app/models/qoute_model.dart';






class DBHelper {
  static String url = 'https://zenquotes.io/api/';

  static Future generateQoute() async {
    final respons = await http.get(Uri.parse("${url}random"));

    try {
      final data = jsonDecode(respons.body);
      print(data[0]);
      return QuoteModel.fromJson(data[0]);
    } catch (e) {
      throw Exception("failed genate qoute...");
    }
  }
}


