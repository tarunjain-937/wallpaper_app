import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/Screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) {
          return const GetMaterialApp(
            title: 'Wallpaper app',
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
    designSize: Size(360, 780));
  }
}
