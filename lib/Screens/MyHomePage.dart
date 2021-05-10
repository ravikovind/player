import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/Methods/AuthMethods.dart';
import 'package:player/Screens/PlayerHelper.dart';
import 'package:player/Screens/PlayerX.dart';
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
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4"
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
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Better Player Plug in  Approach 1",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              ListView.builder(
                itemCount: _list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MaterialButton(
                    child: Text(
                      " Demo video  " + index.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
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
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Better Player Plug in  Approach 2",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              ListView.builder(
                itemCount: _list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MaterialButton(
                    child: Text(
                      " Demo video  " + index.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
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
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Chewie Player Plug in",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              ListView.builder(
                itemCount: _list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MaterialButton(
                    child: Text(
                      " Demo video  " + index.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return PlayerHelper(
                          cameras: widget.cameras,
                          controller:
                              VideoPlayerController.network(_list[index]),
                        );
                      }));
                    },
                  );
                },
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ));
  }
}
