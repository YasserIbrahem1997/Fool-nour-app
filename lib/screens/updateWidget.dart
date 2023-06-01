import '../utils/appTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/consts.dart';
import '../utils/languages_local.dart';
import 'package:launch_review/launch_review.dart';

class UpdateWidget extends StatefulWidget {
  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateWidget> {
  static const String TAG = "updatedscreen";

  // Controllers
  TextEditingController testFieldController = TextEditingController();

  final decorationStyle = TextStyle(color: NormalColor, fontSize: 16.0);
  final hintStyle = TextStyle(color: BackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(elevation: 0.0),
        backgroundColor: Theme.of(context).primaryColor,
        body: buildPhoneAuthBody());
  }

  //--------------------------1St SCREEN UI -----------------------//

  Widget buildPhoneAuthBody() {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Text(
            APPNAME,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: NormalColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Text(
                "Update Now",
                style: decorationStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(flex: 5, child: buildTextInfo()),
                  Flexible(flex: 1, child: buildConfirmInputButton())
                ],
              ),
            ),
          ],
        ))
      ],
    ));
  }

  Widget buildTextInfo() {
    return Text(
      APPNAME,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: NormalColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildConfirmInputButton() {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(Icons.file_download),
      color: BackgroundColor,
      disabledColor: theme.primaryColor,
      onPressed: () => updateNow(),
    );
  }

  updateNow() {
    LaunchReview.launch(
        androidAppId: "com.abdelrahmanashraf.foolnour", iOSAppId: "1517507827");
  }
}
