import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller?.forward();
    controller?.addListener(() {
      setState(() {});
      // print(animation?.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
                onPressed: () {
                  //Go to login screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: 'Register',
                colour: Colors.blueAccent)
          ],
        ),
      ),
    );
  }
}
