//import 'package:better_player/better_player.dart';
import 'package:better_player/better_player.dart';
//import 'package:chewie/chewie.dart';
//import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';


class HomeScreen extends StatefulWidget {
  String url;
  HomeScreen(this.url);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  ChewieController _chewieController;

//  FlickManager flickManager;
  var aspectratio;

  BetterPlayerController _betterPlayerController;
  VideoPlayerController _controller;

  @override
  void initState() {
    print(widget.url);
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url);

    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          controlsConfiguration: BetterPlayerControlsConfiguration(
            progressBarBufferedColor: Colors.white,
            progressBarPlayedColor: Colors.white,
            progressBarBackgroundColor: Colors.white,
            progressBarHandleColor: Colors.white,
              loadingColor: Colors.white,
          )


        ),
        betterPlayerDataSource: betterPlayerDataSource);
//    _controller = VideoPlayerController.network(
//        'https://videostreama.herokuapp.com/video')
//      ..initialize().then((_) {
//        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//        setState(() {});
//      });
//    _controller.addListener(() {
//      if (_controller.value.hasError) {
//        print(
//            '=============================${_controller.value
//                .errorDescription}=============');
//      }
//      if (_controller.value.initialized) {}
////      if (_controller.value.isBuffering) {
////        Center(child: FlickVideoBuffer(bufferingChild: CircularProgressIndicator(),));
////      }
//    });
//    flickManager = FlickManager(videoPlayerController: _controller);

//    _chewieController = ChewieController(
//      videoPlayerController: _controller,
//      autoPlay: true,
//      looping: true,
//
//
//      // Try playing around with some of these other options:
//
//
//       materialProgressColors: ChewieProgressColors(
//
//         playedColor: Colors.blue,
//         handleColor: Colors.blue,
//         backgroundColor: Colors.grey,
//         bufferedColor: Colors.lightGreen,
//
//       ),
//       placeholder: Container(
//         color: Colors.transparent,
//       ),
//
//       autoInitialize: true,
//    );
//    setState(() {});
  }
  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    final deviceratio = width / height;
    return Scaffold(
        body: Center(
          child: Container(
            child: Container(
              width: width ,
              height:height*0.5,
              child: BetterPlayer(controller: _betterPlayerController,),
              ),
              ),
          ),
          );


  }
}
