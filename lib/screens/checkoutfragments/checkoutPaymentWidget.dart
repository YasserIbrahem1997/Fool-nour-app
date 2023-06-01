import 'dart:convert';

import '/bloc/bloc_paymentGateway.dart';
import '/models/api/paymentMethod/getPaymentMethods.dart';
import '/models/checkoutSteps.dart';
import 'package:flutter/material.dart';
import '/payments/paypal.dart';
import '/payments/tap.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';
import '/http/woohttprequest.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../models/api/customer/customerCreateModel.dart';
import '../../utils/prefrences.dart';

class CheckOutPaymentScreen extends StatefulWidget {
  double amount;
  CheckOutStep checkOutStep;

  CheckOutPaymentScreen(this.checkOutStep, this.amount);

  @override
  _CheckOutPaymentScreenState createState() =>
      new _CheckOutPaymentScreenState();
}

List<GetPaymentGateway>? paymentGateways;

class _CheckOutPaymentScreenState extends State<CheckOutPaymentScreen> {
  final String REQUIRED = "__ *";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController notesController = new TextEditingController();

  // Razorpay _razorpay ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WooHttpRequest().getPaymentGatways().then((value) {
      paymentGateways = value;
      paymentGatewayBloc.refreshPaymentGateways(paymentGateways!);
    });
    // _razorpay = Razorpay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: BackgroundColor,
        body: StreamBuilder(
          stream: paymentGatewayBloc.getPaymentGatewayStreamController.stream,
          initialData: paymentGateways,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data != null
                ? _buildBody(context)
                : Center(
                    child: JumpingDotsProgressIndicator(
                    fontSize: 40.0,
                  ));
          },
        ));
  }

  Widget _buildBody(BuildContext context) {
    bool tap = false;
    bool paypal = false;
    bool razorpay = false;
    bool cod = false;
    bool cheque = false;
    bool bacs = false;

    paymentGateways!.forEach((element) {
      if (element.id == "tap" && element.enabled) {
        tap = true;
      } else if (element.id == "paypal" && element.enabled) {
        paypal = true;
      } else if (element.id == "razorpay" && element.enabled) {
        razorpay = true;
      } else if (element.id == "cod" && element.enabled) {
        cod = true;
      } else if (element.id == "cheque" && element.enabled) {
        cheque = true;
      } else if (element.id == "bacs" && element.enabled) {
        bacs = true;
      }
    });

    ProgressDialog pr = ProgressDialog(context: context);
    // pr.style(
    //     message: LocalLanguageString().processingorderrequest+'...',
    //     borderRadius: 10.0,
    //     backgroundColor: BackgroundColor,
    //     progressWidget: CircularProgressIndicator(),
    //     elevation: 10.0,
    //     insetAnimCurve: Curves.easeInOut,
    //     progress: 0.0,
    //     maxProgress: 100.0,
    //     progressTextStyle: TextStyle(color: NormalColor, fontSize: 13.0, fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(color: NormalColor, fontSize: 19.0, fontWeight: FontWeight.w600)
    // );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //
          //   padding: EdgeInsets.all(15),
          //   margin: EdgeInsets.only(bottom: 30,top: 60),
          //   child:  Text(
          //     LocalLanguageString().paymentdescription,
          //     textAlign:TextAlign.center,
          //     style: TextStyle(
          //       fontFamily: "Normal",
          //       fontWeight: FontWeight.w600,
          //       fontSize: 15,
          //       color: NormalColor,
          //     ),
          //   ),
          // ),

          Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ملاحظات',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Header",
                      fontSize: 16,
                      color: MainHighlighter,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      controller: notesController,
                      style: TextStyle(
                        fontFamily: "Header",
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                LocalLanguageString().total,
                style: TextStyle(
                  fontFamily: "Normal",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: NormalColor,
                ),
              ),
              Text(
                "${widget.amount + widget.checkOutStep.stepTwo!.shippmentCost} ${currencyCode == null ? "" : currencyCode}",
                style: TextStyle(
                  fontFamily: "Normal",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: NormalColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          tap
              ? Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextButton(
                    // color: MainHighlighter,
                    onPressed: () async {
                      pr.show(
                        max: 100,
                        msg: '...' +
                            LocalLanguageString().processingorderrequest,
                      );
                      String? url = await WooHttpRequest().getTapUrl(
                          widget.amount,
                          widget.checkOutStep.stepTwo!.shippmentCost,
                          currencyCode);
                      pr.close();
                      if (url != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewTap(
                                  url, widget.checkOutStep.stepTwo!)),
                        );
                      }
                    },
                    child: Text(
                      "pay via Tap",
                      style: TextStyle(
                        fontFamily: "Normal",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: BackgroundColor,
                      ),
                    ),
                  ),
                )
              : Container(),
          paypal
              ? Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextButton(
                    // color: MainHighlighter,
                    onPressed: () async {
                      pr.show(
                        max: 100,
                        msg: LocalLanguageString().processingorderrequest +
                            '...',
                      );
                      String? tokenpaypal =
                          await WooHttpRequest().getAuthPaypal();
                      if (tokenpaypal != null) {
                        Map? urls = await WooHttpRequest().paymentPaypal(
                            tokenpaypal,
                            widget.amount,
                            widget.checkOutStep.stepTwo!.shippmentCost,
                            currencyCode);
                        pr.close();
                        if (urls != null)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPaypal(
                                    tokenpaypal,
                                    urls["approval_url"],
                                    urls["execute"],
                                    widget.checkOutStep.stepTwo!)),
                          );
                      }
                    },
                    child: Text(
                      "Pay via PayPal",
                      style: TextStyle(
                        fontFamily: "Normal",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: BackgroundColor,
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () async {
                pr.show(
                  max: 100,
                  msg: '...' + LocalLanguageString().processingorderrequest,
                );

                Map<String, String> shippmentLineDetail = {
                  "method_id": widget.checkOutStep.stepTwo!.id.toString(),
                  "method_title": widget.checkOutStep.stepTwo!.title,
                  "total":
                      widget.checkOutStep.stepTwo!.shippmentCost.toString(),
                };

                CreateCustomer createCustomer = getCustomerDetailsPref();
                print('createCustomer:');
                print(createCustomer.shipping.toJson());
                // await http.post(
                //   Uri.parse('https://fcm.googleapis.com/fcm/send'),
                //   headers: <String, String>{
                //     'Content-Type': 'application/json',
                //     'Authorization':
                //     'key= AAAA0BI8tCo:APA91bFPHeTBcXyKw-K96_vEfT8qKxn8kfh3ICc9uOMKWzxTjvfQlrTmm_evZo-9BRjTE195M_2gQ41v9yo_efeknpj_VbGITbKiGImCJYWYLtST4Lm4cyUHV4HDxJh78yGmwvzZsmZB',
                //   },
                //   body: jsonEncode({
                //     "to": "token",
                //     "notification": {
                //       'title': body,
                //       'body': title,
                //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
                //       "sound": "default"
                //     },
                //   }),
                // );
                WooHttpRequest()
                    .putNewOrder(context, "cod", "Cash on delivery",
                        shippmentLineDetail, notesController.text)
                    .then((value) {
                  pr.close();
                  Navigator.pushReplacementNamed(context, "/home");
                });
              },
              child: Text(
                "الدفع عند الاستلام",
                style: TextStyle(
                  fontFamily: "Normal",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: NormalColor,
                ),
              ),
            ),
          ),
//          razorpay?Container(
//            padding: EdgeInsets.all(10),
//            width: double.infinity,
//            child: RaisedButton(
//              color: MainHighlighter,
//              onPressed: () async {
//                _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
//                  WooHttpRequest().putNewOrder("razorpay","Razorpay").then((value) {
//                    Navigator.pushReplacementNamed(context, "/home");
//                  });
//                });
//                _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
//                  print("");
//                });
//                var config=getRazorPayConfig(widget.amount,shippingCost,currencyCode);
//                _razorpay.open(config);
//              },
//              child: Text(
//                "Pay via RazorPay",
//                style: TextStyle(
//                  fontFamily: "Normal",
//                  fontWeight: FontWeight.w600,
//                  fontSize: 20,
//                  color: BackgroundColor,
//                ),
//              ),
//            ),
//          ):Container()
        ],
      ),
    );
  }
}
