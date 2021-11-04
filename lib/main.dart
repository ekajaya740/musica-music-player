import 'package:flutter/material.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          filled: true,
          fillColor: primaryColor400,
          focusColor: primaryColor300,
          hoverColor: primaryColor300,
          hintStyle: TextStyle(
            color: primaryColor300,
            fontSize: 12,
          ),
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: primaryColor500,
      ),
      home: const MainScreen(),
    );
  }
}
