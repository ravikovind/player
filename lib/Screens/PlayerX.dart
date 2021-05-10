import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

class PlayerX extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String url;

  const PlayerX({Key key, @required this.cameras, @required this.url})
      : super(key: key);

  @override
  _PlayerXState createState() => _PlayerXState();
}

class _PlayerXState extends State<PlayerX> {
  BetterPlayerController _betterPlayerController;
  CameraController _controller;
  double _value = 1.0;

  @override
  void initState() {
    super.initState();
    if (mounted) WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            child: Stack(
              children: [
                _betterPlayerController == null
                    ? Center(child: CircularProgressIndicator())
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: _betterPlayerController,
                        ),
                      ),
                _controller.value.isInitialized
                    ? Positioned(
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
                                  color: Colors
                                      .orange, //                   <--- border color
                                  width: 1.0,
                                ),
                              ),
                              child: Transform.rotate(angle: -pi/2,
                              child: CameraPreview(_controller))),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 1.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
            ),
            child: Slider(
              value: _value,
              min: 0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  _betterPlayerController.setVolume(_value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
