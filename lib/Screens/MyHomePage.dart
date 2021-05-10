import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/Methods/AuthMethods.dart';
import 'package:player/Screens/PlayerY.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MyHomePage({Key key, @required this.cameras}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _list = [
    "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
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
                return PlayerY(
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
