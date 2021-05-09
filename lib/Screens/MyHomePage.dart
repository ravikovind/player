import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/Screens/PlayerHelper.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MyHomePage({Key key, @required this.cameras}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _list = [
    "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
    "https://vod-progressive.akamaized.net/exp=1620556503~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F688%2F17%2F428442047%2F1859369268.mp4~hmac=81bb38177e364eedd1ba0f048f19565c82900479a7738432a8b6ef2b1fee7add/vimeo-prod-skyfire-std-us/01/688/17/428442047/1859369268.mp4?filename=production+ID%3A4629650.mp4",
    "https://vod-progressive.akamaized.net/exp=1620545741~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F647%2F20%2F503235672%2F2298754321.mp4~hmac=c804b3298b28bdd6c37bf0988cc374e4766582cce0112d23aa2e5dd456b09f14/vimeo-prod-skyfire-std-us/01/647/20/503235672/2298754321.mp4?filename=pexels-mikhail-nilov-6563976.mp4",
    "https://vod-progressive.akamaized.net/exp=1620556577~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1620%2F19%2F483102170%2F2162828484.mp4~hmac=ea8a71d70bf1851432717b71014e8fab3a2d3e929606d47a32fade7ba7bbfbd0/vimeo-prod-skyfire-std-us/01/1620/19/483102170/2162828484.mp4?filename=pexels-jack-sparrow-5977450.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Player"),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return MaterialButton(
            child: Text("video  " + index.toString()),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PlayerHelper(
                    cameras: widget.cameras,
                    controller: VideoPlayerController.network(_list[index]));
              }));
            },
          );
        },
      ),
    );

    //   body: Center(
    //     child: MaterialButton(
    //       child: Icon(
    //         Icons.play_arrow_rounded,
    //         size: 80,
    //       ),
    //       onPressed: () {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 fullscreenDialog: true,
    //                 builder: (BuildContext context) {
    //                   return PlayerHelper(
    //                       cameras: widget.cameras,
    //                       controller: VideoPlayerController.network(
    //                           "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"));
    //                 }));
    //       },
    //     ),
    //   ),
    // );
  }
}
