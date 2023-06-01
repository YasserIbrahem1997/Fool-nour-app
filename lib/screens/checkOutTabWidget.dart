import '/models/checkoutSteps.dart';
import '/http/woohttprequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/WidgetHelper/checkOutButton.dart';
import '/bloc/bloc_checkout.dart';
import '/emuns/checkOutType.dart';
import '/screens/checkoutfragments/checkoutPaymentWidget.dart';
import '/screens/checkoutfragments/checkoutProfileWidget.dart';
import '/screens/checkoutfragments/checkoutShippingWidget.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';

class CheckOutTabScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => new _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutTabScreen>
    with CheckOutButton {
  CheckOutStep? checkOutStep;
  bool? isFreeShipment;

  @override
  void initState() {
    super.initState();
    checkOutStep = CheckOutStep();
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context)!.settings.arguments as Map;
    double amount = map['_amount'];
    isFreeShipment = map['_freeShipment'] ?? false;

    return Container(
      color: BackgroundColor,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 1,
              child: Container(
                color: BackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.arrow_back,
                            color: MainHighlighter,
                            size: 25,
                          ),
                        )),
                    Text(
                      LocalLanguageString().checkout,
                      style: TextStyle(
                        color: MainHighlighter,
                        fontSize: 20.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Header",
                        letterSpacing: 1.2,
                      ),
                    ),
                    Container(),
                  ],
                ),
              )),
          Expanded(flex: 13, child: body(amount))
        ],
      ),
    );
  }

  Widget body(double amount) {
    return Container(
        child: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Divider(),
        Expanded(
          flex: 1,
          child: StreamBuilder(
            stream: checkOutBloc.selectCheckoutStreamController.stream,
            initialData: CheckOutType.ADDRESS,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data != null
                  ? getCheckOutTab(snapshot.data)
                  : Container();
            },
          ),
        ),
        Expanded(
            flex: 9,
            child: StreamBuilder(
              stream: checkOutBloc.selectCheckoutStreamController.stream,
              initialData: CheckOutType.ADDRESS,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data == CheckOutType.ADDRESS) {
                    return CheckOutProfileScreen(checkOutStep!);
                  } else if (snapshot.data == CheckOutType.SHIPPING &&
                      checkOutStep!.stepOne!.selectedShippingZone != null) {
                    return CheckOutShippingScreen(
                        checkOutStep!, isFreeShipment!);
                  } else if (snapshot.data == CheckOutType.PAYMENT) {
                    return CheckOutPaymentScreen(checkOutStep!, amount);
                  } else
                    return Container();
                } else
                  return Container();
              },
            )),
      ],
    ));
  }
}
