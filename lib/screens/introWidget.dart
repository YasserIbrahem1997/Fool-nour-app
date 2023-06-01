import 'package:flutter/material.dart';
import '../utils/appTheme.dart';
import '../utils/consts.dart';
import '../utils/languages_local.dart';
import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => new _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static final String path =
      "lib/src/pages/onboarding/smart_wallet_onboarding.dart";
  final slides = [
    // Slide(
    //   title: APPNAME,
    //   styleTitle: TextStyle(
    //       color: NormalColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'RobotoMono'),
    //   // description: "WooFlux Store is your one-stop online shopping marketplace World wide bringing a reliable, hassle-free and convenient shopping experience to your fingertips. ",
    //   styleDescription: TextStyle(
    //       color: NormalColor,
    //       fontSize: 15.0,
    //       fontStyle: FontStyle.italic,
    //       fontFamily: 'Raleway'),
    //   pathImage: "assets/splashone.png",
    //   backgroundColor: BackgroundColor,
    // ),
    // Slide(
    //   title: APPNAME,
    //   styleTitle: TextStyle(
    //       color: NormalColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'RobotoMono'),
    //   // description: "Founded on the precipice of trust and peace of mind, WooFlux Store aims to provide an unfailing and absolutely trouble-free shopping experience to the people of World.",
    //   styleDescription: TextStyle(
    //       color: NormalColor,
    //       fontSize: 15.0,
    //       fontStyle: FontStyle.italic,
    //       fontFamily: 'Raleway'),
    //   pathImage: "assets/splashtwo.png",
    //   backgroundColor: BackgroundColor,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // IntroSlider(
            //   slides: this.slides,
            //   renderDoneBtn: this.renderDoneBtn(),
            //   onDonePress: this.onDonePress,
            //   renderSkipBtn: this.renderSkipBtn(),
            //   onSkipPress: this.onSkipPress,
            //   // highlightColorSkipBtn: MainHighlighter,
            //
            //   // Next, Done button
            //   // colorDoneBtn: MainHighlighter,
            //   // highlightColorDoneBtn: MainHighlighter,
            //   // Dot indicator
            //   colorDot: MainHighlighter,
            //   colorActiveDot: SecondaryHighlighter,
            //   sizeDot: 13.0,
            // )
          ],
        ),
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "Done",
      style: TextStyle(
          color: NormalColor, fontSize: 18.0, fontFamily: 'RobotoMono'),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip",
      style: TextStyle(
          color: NormalColor, fontSize: 18.0, fontFamily: 'RobotoMono'),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
