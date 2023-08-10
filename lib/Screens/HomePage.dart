import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/Model/wallpaperClassModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> category=[
    "Street art",
    "Wild life",
    "Nature",
    "City",
    "Motivation",
  ];

  List<String> imgSource= [
    "lib/Images/img1.jpg",
    "lib/Images/img2.jpg",
    "lib/Images/img3.jpg",
    "lib/Images/img4.jpg",
    "lib/Images/img5.jpg"
  ];

  String apiKey="CAGWT7kaldvOhSk9u0LPtEUKLDt0KidTVdlS8fvBA24TuWvhG0OsoBN1";
  Future<WallpaperClassModel> getWallpapers() async{
    String url = " https://api.pexels.com/v1/curated?page=1&per_page=40";
    final response = await http.get(Uri.parse(url),
    headers:{
      "Authorization":apiKey
    });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WallpaperClassModel.fromJson(data);
    } else {
      return WallpaperClassModel.fromJson(data);
    }
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.w,color: Colors.black),
                borderRadius: BorderRadius.circular(50.r),
                color: Color.fromRGBO(196, 223, 223, 1),
              ),
              height: 45.h, width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.only(left: 30.w,right: 15.w,top: 0.h,bottom: 0.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search wallpaper",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.black)
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.black),
                       autocorrect: true,
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30.sp,color: Colors.black,))
                  ],
                ),
              ),
            ),

            Container( height: 100.h,width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount:category.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(height: 63.h, width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(width: 2.w,color: Colors.black),
                              image: DecorationImage(image: AssetImage(imgSource[index]),fit: BoxFit.cover),
                            ),),
                          Text(category[index],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.sp),)
                        ],
                      ),
                    );
                  },),
            ),

            Row(
              children: [
                Expanded(child: Divider(indent: 10.w,thickness: 2.sp,endIndent: 10.w)),
                Text(" Wallpapers ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Expanded(child: Divider(indent: 10.w,thickness: 2.sp,endIndent: 10.w)),
              ],
            ),

            //---------------------------
            Expanded(
              child: FutureBuilder<WallpaperClassModel>(
                future: getWallpapers(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.photos!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 400,
                              color: Colors.orange,
                            ),
                          );
                        },);
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },),
            )
          ],
        ),
      ),
    );
  }
}
