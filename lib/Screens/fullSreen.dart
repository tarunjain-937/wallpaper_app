import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  const FullScreen({Key? key,required this.imageUrl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper()async {
    int Location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, Location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageUrl,fit: BoxFit.cover,),
            )),
            Container(width: double.infinity,
              child: ElevatedButton(onPressed: (){
                setWallpaper();
              },
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: Text("Set Wallpaper",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }
}
