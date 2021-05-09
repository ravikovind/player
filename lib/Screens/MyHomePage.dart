import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/Methods/AuthMethods.dart';
import 'package:player/Screens/PlayerX.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MyHomePage({Key key, @required this.cameras}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _list = [
    "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
    "https://vod-progressive.akamaized.net/exp=1620579828~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F933%2F18%2F454669949%2F2004067596.mp4~hmac=217129742db0ad044ea6f1f1621936d17ba6dc7409981f033f128367d6db1cdc/vimeo-prod-skyfire-std-us/01/933/18/454669949/2004067596.mp4?filename=pexels-taryn-elliott-5271945.mp4",
    "https://vod-progressive.akamaized.net/exp=1620579778~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3253%2F17%2F441265011%2F1930380741.mp4~hmac=940bd8bfa85f2ecb363e3bf1e2639e59d38d4b7ee293c7f017e35189f0f67c5f/vimeo-prod-skyfire-std-us/01/3253/17/441265011/1930380741.mp4?filename=production+ID%3A4942181.mp4",
    "https://vod-progressive.akamaized.net/exp=1620579251~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F402%2F14%2F352012012%2F1427930346.mp4~hmac=b3d4b2886e5bf4d120813cf9bd0d2873ce447bb461415e5545da1a6961278c04/vimeo-prod-skyfire-std-us/01/402/14/352012012/1427930346.mp4?filename=Pexels+Videos+2759477.mp4",
  ];

  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Player"),
        actions: [
          IconButton(
              onPressed: () {
                authMethods.signOut().whenComplete(() {
                  setState(() {});
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return MaterialButton(
            child: Text(" Demo video  " + index.toString()),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PlayerX(
                  cameras: widget.cameras,
                  url: _list[index],
                );
              }));
            },
          );
        },
      ),
    );
  }
}
