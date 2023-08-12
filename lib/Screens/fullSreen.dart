import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
             top: 760, left: 130,
            child: InkWell(
              onTap: (){
                setWallpaper();
                Timer(Duration(seconds: 1),() {
                  Get.snackbar("","",
                      messageText: Text("Thankyou for using Wallpaper Hub"),
                      titleText: Text("wallpaper is set",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700),));
                });
                Timer(Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white,width: 2)
                ),
                padding: EdgeInsets.all(12),
                child: Text("Set Wallpaper",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black),),
              ),
            ),
          )
        ]
      ),
    );
  }
}

/*
* Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            )
* */
