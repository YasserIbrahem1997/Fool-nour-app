import '../bloc/bloc_shippingZone.dart';
import '../models/api/shippingZone/getShippingZone.dart';
import '../http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../WidgetHelper/profileInfo.dart';
import '../bloc/bloc_checkout.dart';
import '../emuns/checkOutType.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../utils/prefrences.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:progress_indicators/progress_indicators.dart';

class UserProfileScreen extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile3.dart";

  var shippingZones;


  @override
  Widget build(BuildContext context) {
    WooHttpRequest().getShippingZones().then((value) {
      shippingZones=value;
      shippingZoneBloc.refreshShippingZones(shippingZones);
    });

    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(color: MainHighlighter,)
            ),
            Expanded(
                flex: 1,
                child: Container(
                  color: MainHighlighter,
                  // color: NormalColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            width: 40,

                            child: Icon(Icons.arrow_back,
                              color: BackgroundColor,
                              size: 25,),
                          )
                      ),

                       Container(),
                    ],
                  ),
                )
            ),
            Expanded(
              flex: 13,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      color: MainHighlighter,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            color: BackgroundColor,
                            size: 70,
                          ),
                          Text(
                            "Profile Setting",
                            style: TextStyle(
                              color: BackgroundColor,
                              fontSize: 22.0,
                              fontFamily: "Header",
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: shippingZoneBloc.getShippingZoneStreamController.stream,
                      initialData: shippingZones,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return (snapshot.data!=null && snapshot.data.length >0 )?
                        ProfileInfo(
                          onTap:(GetShippingZone selectedShippingZone) async {
                            Navigator.of(context).pop();
                          },
                          shippingZones: shippingZones,
                        ):
                        Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,color: MainHighlighter,));
                      },
                    ),
                  ],
                )

              )
            )

          ],
        ),
      ) ,
    );
  }

}

