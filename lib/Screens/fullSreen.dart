import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  const FullScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper() async {
    int Location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, Location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wallpaper ",style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("Hub",style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.bold,color: Colors.blueAccent),)
          ],
        ),
      ),
      body: Stack(
        children: [
          Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              )),

          Positioned(
             top: 600.h, left: 120.w,
            child: InkWell(
              onTap: (){
                setWallpaper();
                Timer(Duration(seconds: 1),() {
                  Get.snackbar("","",
                      messageText: Text("Thankyou for using Wallpaper Hub"),
                       margin: EdgeInsets.only(top: 100.h),
                      titleText: Text("wallpaper is set",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),));
                });
                Timer(Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(color: Colors.white,width: 2.w)
                ),
                padding: EdgeInsets.all(12.sp),
                child: Text("Set Wallpaper",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: Colors.black),),
              ),
            ),
          )
        ]
      ),
    );
  }
}
