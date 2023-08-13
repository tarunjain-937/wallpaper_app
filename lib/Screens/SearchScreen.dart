import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'fullSreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.SearchController}) : super(key: key);

  final String SearchController;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchQuery = widget.SearchController;
    getWallpapers();
  }

  late String searchQuery;
  List images=[];
  int page = 1;
  bool loading = false;
  String apiKey="CAGWT7kaldvOhSk9u0LPtEUKLDt0KidTVdlS8fvBA24TuWvhG0OsoBN1";

  getWallpapers() async{
    setState(() {
      loading = true;
    });

    String url = "https://api.pexels.com/v1/search?query=${searchQuery.toString()}&per_page=40";
    await http.get(Uri.parse(url),
        headers:{"Authorization":apiKey}).then((value){
      Map result = jsonDecode(value.body);
      setState(() {
        loading = false;
        images = result["photos"];
      });
      print(images.length);
    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
      Get.snackbar("","",
        titleText: Text(error.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16)),
        messageText: Text("Try Some another query, Thankyou!!"),);
    });
  }

  loadMore() async{
    setState(() {
      page=page+1;
    });
    String url= "https://api.pexels.com/v1/search?query=${searchQuery.toString()}&per_page=40&page="+page.toString();
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
          children: [
            Text("${widget.SearchController} ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("Wallpapers ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
          ],
        ),
      ),
      body:  loading ? Center(child: CircularProgressIndicator()) : Stack(
          children:[
            GridView.builder(
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

            Container(
              margin: EdgeInsets.only(top: 625.h,left:127.w),
              child: InkWell(
                onTap: (){
                  loadMore();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: Colors.white,width: 2.w)
                  ),
                  padding: EdgeInsets.all(8.sp),
                  child: Text("Load more",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: Colors.black),),
                ),
              ),
            )
          ]
      ),
    );
  }
}
