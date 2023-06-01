import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer!.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context)!.insert(_overlayEntry!);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message) {

    return OverlayEntry(
        builder: (context) => Positioned(
          top: 50.0,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding:
              EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xffe53e3f),
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          )),
        ));
  }
}

class ToastMessageAnimation extends StatelessWidget {
  final Widget child;

  ToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("translateY").add(
    //     Duration(milliseconds: 250),
    //     Tween(begin: -100.0, end: 0.0),
    //     curve: Curves.easeOut,
    //   ).add(Duration(seconds: 1, milliseconds: 250),
    //       Tween(begin: 0.0, end: 0.0))
    //       .add(Duration(milliseconds: 250),
    //       Tween(begin: 0.0, end: -100.0),
    //       curve: Curves.easeIn),
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500),
    //       Tween(begin: 0.0, end: 1.0))
    //       .add(Duration(seconds: 1),
    //       Tween(begin: 1.0, end: 1.0))
    //       .add(Duration(milliseconds: 500),
    //       Tween(begin: 1.0, end: 0.0)),
    // ]);

    return Container(color: Colors.teal,width: 50,);



    //   PlayAnimation(
    //   duration: const Duration(seconds: 5),
    //   tween: ColorTween(begin: Colors.red, end: Colors.blue),
    //   child: child,
    //   builder: (BuildContext context, Widget? child, value) => Opacity(
    //     opacity: (value as Map)["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, (value as Map)["translateY"]),
    //         child: child),
    //   ),
    // );
  }
}