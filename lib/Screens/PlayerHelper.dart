import 'dart:math';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlayerHelper extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController controller;
  final List<CameraDescription> cameras;

  const PlayerHelper(
      {Key key, @required this.controller, @required this.cameras})
      : super(key: key);

  @override
  _PlayerHelperState createState() => _PlayerHelperState();
}

class _PlayerHelperState extends State<PlayerHelper>
    with TickerProviderStateMixin {
  ChewieController _chewieController;
  CameraController controller;

  @override
  void initState() {
    super.initState();
    if (mounted) WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]); // Wrapper on top of the videoPlayerController

    controller = CameraController(widget.cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    try {
      _chewieController = ChewieController(
        videoPlayerController: widget.controller,
        aspectRatio: 16 / 9,
        looping: true,
        allowFullScreen: false,
        autoInitialize: true,
        // Prepare the video to be played and display the first frame
        allowPlaybackSpeedChanging: false,
        // Errors can occur for example when trying to play a video
        // from a non-existent URL
        errorBuilder: (context, errorMessage) {
          return Container();
        },
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              _chewieController != null &&
                      _chewieController
                          .videoPlayerController.value.isInitialized
                  ? Center(child: CircularProgressIndicator())
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    ),
              controller.value.isInitialized
                  ? Positioned(
                      width: 64.0,
                      height: 64.0,
                      right: 2.0,
                      bottom: MediaQuery.of(context).size.width * 0.075,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                        2.0) //                 <--- border radius here
                                    ),
                                border: Border.all(
                                  color: Colors
                                      .black, //                   <--- border color
                                  width: 1.0,
                                ),
                              ),
                              child: CameraPreview(controller)),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    widget.controller.dispose();
    controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
    // IMPORTANT to dispose of all the used resources
  }
}
