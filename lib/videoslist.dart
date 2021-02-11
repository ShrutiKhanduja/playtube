import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:better_player/better_player.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:playtube/Classes/thumbnails.dart';
import 'package:playtube/home_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';



class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {

  VideoPlayerController _controller;
  BetterPlayerController _betterPlayerController;

    Future<String> getvideos() async {
      HttpClient httpClient = new HttpClient();
      final String apiUrl = "https://videostreama.herokuapp.com/api/allvideos";
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      response.transform(utf8.decoder).listen((contents) {
        print(contents);
        var data = jsonDecode(contents);


       print(data);
      for(var d in data){
        print(d['_id'].toString());
        print(d['thumbnail'].toString());
//        getthumb(d['thumbnail'].toString());

        thumbnails thu=thumbnails(d['title'],d['description'],d['thumbnail'],d['video'].toString().substring(13));
        setState(() {
          allimages.add(thu);
        });
       print(allimages.length);
      }
      });
      httpClient.close();

    }

//  Future<String> getthumb(String id) async {
//      print(id);
//    HttpClient httpClient = new HttpClient();
//    final String apiUrl = "https://videostreama.herokuapp.com/api/image?id=${id}";
//    HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
//    request.headers.set('content-type', 'application/json');
//    HttpClientResponse response = await request.close();
//    response.transform(utf8.decoder).listen((contents) {
////      print(contents);
//print('--------------------');
//
//    });
//    httpClient.close();
//
//  }

 List<thumbnails>allimages=[];
//  ChewieController _chewieController;
@override
  void initState() {
  getvideos();
  super.initState();
//  BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//      BetterPlayerDataSourceType.network,
//      "https://firebasestorage.googleapis.com/v0/b/doctorappointmentmodule.appspot.com/o/download.mp4?alt=media&token=16e16ebd-90f4-4dcb-b3a6-90fa577c3e3f");
//
//  _betterPlayerController = BetterPlayerController(
//      BetterPlayerConfiguration(
//          controlsConfiguration: BetterPlayerControlsConfiguration(
//              progressBarBufferedColor: Colors.white,
//              progressBarPlayedColor: Colors.white,
//              progressBarBackgroundColor: Colors.white,
//              progressBarHandleColor: Colors.white
//          )
//
//
//      ),
//      betterPlayerDataSource: betterPlayerDataSource);
//
////    _controller = VideoPlayerController.network('https://videostreama.herokuapp.com/video')
////
////      ..initialize().then((_) {
////        setState(() {});  //when your thumbnail will show.
////      });

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Playtube',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body:Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: allimages.length,
            itemBuilder: (context,index){
          return allimages.length!=0?Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen('https://videostreama.herokuapp.com/api/video?id=${allimages[index].videourl}')));
              },
              child: Card(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: 'https://videostreama.herokuapp.com/api/image?id=${allimages[index].image}',
                      shimmerDuration: Duration(seconds: 2),
                     height: MediaQuery.of(context).size.height * 0.25,
                       width: MediaQuery.of(context).size.width * 0.95,
                      boxFit: BoxFit.fill,
                    ),
//                    Image.network('https://videostreama.herokuapp.com/api/image?id=${allimages[index].image}',loadingBuilder: (BuildContext,Widget child,ImageChunkEvent loadingProgress){
//                      if(loadingProgress==null) return child;
//                      return Center(
//                        child:Container(
//                          height:MediaQuery.of(context).size.height*0.3,
//                          width:MediaQuery.of(context).size.width*0.8 ,
//
//                          ),
//
//                      );
//
//                    } ,),
                    Align(
                      alignment:Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(allimages[index].title),
                      ),
                    )
                  ],
                )
              ),
            ),
          ):Center(
            child:Container(
              height:100,
              width:100,
              child:CircularProgressIndicator()
            )
          );
        }),
      )
    );
  }
}
