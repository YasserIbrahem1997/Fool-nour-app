
import '/bloc/bloc_shippingZone.dart';
import '/models/api/shippingZone/getShippingZone.dart';
import '/models/checkoutSteps.dart';
import '/http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '/WidgetHelper/profileInfo.dart';
import '/emuns/checkOutType.dart';
import '/utils/appTheme.dart';
import '/bloc/bloc_checkout.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CheckOutProfileScreen extends StatefulWidget {
  CheckOutStep checkOutStep;
  CheckOutProfileScreen( this.checkOutStep );

  @override
  _ConfirmOrderPageState createState() => new _ConfirmOrderPageState();
}

List<GetShippingZone>? shippingZones;
class _ConfirmOrderPageState extends State<CheckOutProfileScreen>  {

  final String REQUIRED="__ *";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WooHttpRequest().getShippingZones().then((value) {
      shippingZones=value;
      shippingZoneBloc.refreshShippingZones(shippingZones!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BackgroundColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {

    Map map= ModalRoute.of(context)!.settings.arguments as Map;
    double amount=map['_amount'];

    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
          stream: shippingZoneBloc.getShippingZoneStreamController.stream,
          initialData: shippingZones,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return (snapshot.data!=null && snapshot.data.length >0 )?
            ProfileInfo(
              onTap:(GetShippingZone selectedShippingZone) async {
                widget.checkOutStep.stepOne!.selectedShippingZone=selectedShippingZone;
                checkOutBloc.selectCheckOut(CheckOutType.SHIPPING);
              },
              shippingZones: shippingZones!,
            ):
            Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,));
          },
        ),
      ),
    );
  }

}