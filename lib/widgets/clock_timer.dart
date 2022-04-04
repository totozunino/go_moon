import 'dart:async';
import 'package:flutter/material.dart';

class FormatedTime extends StatelessWidget {
  final DateTime now;

  const FormatedTime({Key? key, required this.now}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      now.toString().split(' ')[1].substring(0, 8),
      style: const TextStyle(
        fontSize: 42,
      ),
    );
  }
}

class FormatedDate extends StatelessWidget {
  final DateTime now;

  const FormatedDate({Key? key, required this.now}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> splitedDate = now.toString().split(' ')[0].split('-');

    return Text("${splitedDate[1]}/${splitedDate[2]}");
  }
}

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

  @override
  State<ClockTimer> createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  DateTime now = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          now = DateTime.now();
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormatedTime(
          now: now,
        ),
        FormatedDate(
          now: now,
        ),
      ],
    );
  }
}
