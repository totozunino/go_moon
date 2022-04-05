import 'package:go_moon/blocs/moon/models/moon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoonRepository {
  const MoonRepository();

  Future<Moon> getMoonData() async {
    final response = await http
        .get(Uri.parse('https://www.icalendar37.net/lunar/app/now/?lang=en'));

    if (response.statusCode == 200) {
      Map<String, dynamic> rawData = jsonDecode(response.body);

      return Moon.fromJson(
        {"phase": rawData["nomFase"], "ilumination": rawData["iluminacio"]},
      );
    } else {
      throw Exception('Failed to load moon');
    }
  }
}
