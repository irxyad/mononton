import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mononton/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.transparent)),
        defaultTransition: Transition.fadeIn,
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
