import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:player/Methods/AuthMethods.dart';

class LogInPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const LogInPage({Key key, @required this.cameras}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.050,
            ),
            Text(
              "Sign in / Log in",
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              padding: EdgeInsets.all(80),
              child: Image(
                image: AssetImage("images/2.png"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.20,
                  vertical: 32.0),
              child: MaterialButton(
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  authMethods.signInWithGoogle().whenComplete(() {
                    setState(() {});
                  });
                },
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
