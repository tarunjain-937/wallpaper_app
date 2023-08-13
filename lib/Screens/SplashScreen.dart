import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/Screens/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Duration splashTime = Duration(seconds: 3);
    Timer(splashTime, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      },));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 320.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wallpaper ",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color: Colors.white,fontSize: 35.sp),),
                Text("Hub",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color:Colors.blueAccent,fontSize: 38.sp),),
              ],
            ),
            SizedBox(height: 300),
            Text("Developed by :-",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color: Colors.white,fontSize: 16.sp),),
            Text("Tarun jain",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color:Colors.blueAccent,fontSize: 24.sp),),
          ],
        ),
      ),
    );
  }
}
