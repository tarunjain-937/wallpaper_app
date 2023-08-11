import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/Screens/fullSreen.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallpapers();
  }

  List images=[];
  int page = 1;
  String apiKey="CAGWT7kaldvOhSk9u0LPtEUKLDt0KidTVdlS8fvBA24TuWvhG0OsoBN1";

   getWallpapers() async{
    String url = "https://api.pexels.com/v1/curated?page=1&per_page=40";
    await http.get(Uri.parse(url),
    headers:{"Authorization":apiKey}).then((value){
    Map result = jsonDecode(value.body);
    setState(() {
      images = result["photos"];
    });
    print(images.length);
    });
  }

  loadMore() async{
     setState(() {
       page=page+1;
     });
     String url= "https://api.pexels.com/v1/curated?page=1&per_page=40&page="+page.toString();
     await http.get(Uri.parse(url),
         headers:{"Authorization":apiKey}).then((value){
           Map result = jsonDecode(value.body);
           setState(() {
             images.addAll(result['photos']);
           });
     });
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
        padding: const EdgeInsets.only(bottom: 0,top: 8),
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
              child: GridView.builder(
                itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, childAspectRatio: 2/3, mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return FullScreen(imageUrl: images[index]["src"]["large2x"]);
                        },));
                      },
                      child: Container(
                        color: Colors.grey,
                        child: Image.network(images[index]["src"]["tiny"],fit: BoxFit.cover,),
                      ),
                    );
                  },),
            ),

            //-----------------------------
            Container(width: double.infinity,
              child: ElevatedButton(onPressed: (){ loadMore();},
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: Text("Load More",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }
}
