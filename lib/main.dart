import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) {
          return const MaterialApp(
            title: 'Wallpaper app',
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
    designSize: Size(360, 780));
  }
}
