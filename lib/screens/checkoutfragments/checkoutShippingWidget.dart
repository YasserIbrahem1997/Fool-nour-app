import '/bloc/bloc_shippingZoneMethod.dart';
import '/models/api/shippingZoneMethod/getShippingZoneMethods.dart';
import '/models/checkoutSteps.dart';
import '/http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '/bloc/bloc_checkout.dart';
import '/emuns/checkOutType.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CheckOutShippingScreen extends StatefulWidget {

  CheckOutStep checkOutStep;
  bool isFreeShipment;
  CheckOutShippingScreen(this.checkOutStep, this.isFreeShipment);
  @override
  _CheckOutShippingState createState() => new _CheckOutShippingState();
}

List<GetShippingZoneMethods>? shippingZoneMethods;
class _CheckOutShippingState extends State<CheckOutShippingScreen>  {

  final String REQUIRED="__ *";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _groupValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WooHttpRequest().getShippingZonesMethod(widget.checkOutStep.stepOne!.selectedShippingZone.id).then((value) {
      shippingZoneMethods=value;
      if(shippingZoneMethods!.length>0) {
        widget.checkOutStep.stepTwo!.shippmentCost = double.parse(widget.isFreeShipment ? 0.toString() : shippingZoneMethods![0].cost.toString());
        widget.checkOutStep.stepTwo!.id =  shippingZoneMethods![0].id;
        widget.checkOutStep.stepTwo!.title =  shippingZoneMethods![0].title;
      }
      shippingZoneMethodBloc.refreshShippingZoneMethods(shippingZoneMethods!);
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
    return SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
        child: StreamBuilder(
          stream: shippingZoneMethodBloc.getShippingZoneMethodsStreamController.stream,
          initialData: shippingZoneMethods,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return (snapshot.data!=null )?
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: []..addAll(
                    shippingZoneMethods!=null&&shippingZoneMethods!.length>0?shippingZoneMethods!.map((method) {
                      String title = method.title==null?"":method.title;
                      String cost = method.cost==null?"":method.cost;

                      return _myRadioButton(
                        title: title+" ("+(widget.isFreeShipment?LocalLanguageString().free:cost)+")",
                        value: shippingZoneMethods!.indexOf(method),
                        onChanged: (newValue) => setState((){
                          _groupValue = newValue;
                          widget.checkOutStep.stepTwo!.shippmentCost=widget.isFreeShipment?0:double.parse(method.cost);
                          widget.checkOutStep.stepTwo!.id =  method.id;
                          widget.checkOutStep.stepTwo!.title =  method.title;
                        }),
                      );
                    }).toList():
                    [
                      Center(child: Container(child: Text("Shippment not found")))
                    ]
                )
                  ..add(SaveButton())
            ):
            Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,));
          },
        )
    );
  }


  Widget _myRadioButton({String? title, int? value, Function(dynamic?)? onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(
        title!,
        style: TextStyle(
          fontFamily: "Normal",
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: NormalColor,
        ),),
    );
  }

  SaveButton( ) {
    return GestureDetector(
        onTap: () {
          checkOutBloc.selectCheckOut(CheckOutType.PAYMENT);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MainHighlighter,
          ),
          child: Text(
            LocalLanguageString().gotopayment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Normal",
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: NormalColor,
            ),
          ),
        )
    );
  }

}