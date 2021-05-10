import 'dart:math';

import 'package:better_player/better_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PlayerY extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String url;

  const PlayerY({Key key, @required this.cameras, @required this.url})
      : super(key: key);

  @override
  _PlayerYState createState() => _PlayerYState();
}

class _PlayerYState extends State<PlayerY> {
  BetterPlayerController _betterPlayerController;
  CameraController _controller;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.cameras[1], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          fullScreenByDefault: true,
          overlay: Positioned(
            width: 84.0,
            height: 84.0,
            right: 0.0,
            bottom: 0.0,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            2.0) //                 <--- border radius here
                        ),
                    border: Border.all(
                      color:
                          Colors.orange, //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  child: Transform.rotate(
                      angle: -pi / 2, child: CameraPreview(_controller))),
            ),
          ),
          looping: true,
          showPlaceholderUntilPlay: false,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Container(child: Text("Something went wrong!!")),
            );
          },
        ),
        betterPlayerDataSource: betterPlayerDataSource);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController?.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _betterPlayerController == null
          ? Center(child: CircularProgressIndicator())
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                controller: _betterPlayerController,
              ),
            ),
    );
  }
}
