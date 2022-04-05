import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_moon/blocs/moon/moon_repository.dart';
import 'package:go_moon/widgets/moon_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Moon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      home: RepositoryProvider(
        create: (context) => const MoonRepository(),
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const MoonInfo(),
          ),
        ),
      ),
    );
  }
}
