import 'package:flutter/material.dart';
import 'package:go_moon/models/moon.dart';
import 'package:go_moon/utils/utils.dart';
import 'package:go_moon/widgets/clock_timer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoonInfo extends StatefulWidget {
  const MoonInfo({Key? key}) : super(key: key);

  @override
  State<MoonInfo> createState() => _MoonInfoState();
}

class _MoonInfoState extends State<MoonInfo> {
  late Future<Moon> futureMoon;

  Future<Moon> fetchMoon() async {
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

  @override
  void initState() {
    super.initState();
    futureMoon = fetchMoon();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Moon>(
      future: futureMoon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Moon moon = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ClockTimer(),
              const SizedBox(
                height: 65,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200.withOpacity(0.2),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                  child: Image.asset(
                    "assets/images/${toSnakeCase(moon.phase)}.png",
                    fit: BoxFit.cover,
                    width: 82,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                moon.phase,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Ilumination ${moon.ilumination}%",
              ),
              const SizedBox(
                height: 85,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }

        return const Text("Loading");
      },
    );
  }
}
