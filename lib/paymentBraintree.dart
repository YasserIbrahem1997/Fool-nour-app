//import 'package:flutter/material.dart';
//import 'package:flutter_braintree/flutter_braintree.dart';
//import 'package:ecom/screens/splashWidget.dart';
//import 'package:ecom/utils/consts.dart';
//import 'package:ecom/woohttprequest.dart';
//
//class PaymentBraintree{
//  Future<String> braintree(BuildContext context,double amount) async {
//
//  //=-----------------------
//
//    String token = await WooHttpRequest().getToken();
//
//    if(token!=null) {
//      var request = BraintreeDropInRequest(
//        tokenizationKey: token,
//        collectDeviceData: true,
//        googlePaymentRequest: BraintreeGooglePaymentRequest(
//          totalPrice: amount.toString(),
//          currencyCode: currencyCode,
//          billingAddressRequired: false,
//        ),
//        paypalRequest: BraintreePayPalRequest(
//          amount: amount.toString(),
//          displayName: 'Flutter Product',
//        ),
//      );
//      BraintreeDropInResult result = await BraintreeDropIn.start(request);
//      if (result != null) {
//        return result.paymentMethodNonce.nonce;
//        //showNonce(context,result.paymentMethodNonce);
//      }
//      return null;
//    }
//    return null;
//  }
//
//  void showNonce(BuildContext context,BraintreePaymentMethodNonce nonce) {
//    showDialog(
//      context: context,
//      builder: (_) => AlertDialog(
//        title: Text('Payment method nonce:'),
//        content: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Text('Nonce: ${nonce.nonce}'),
//            SizedBox(height: 16),
//            Text('Type label: ${nonce.typeLabel}'),
//            SizedBox(height: 16),
//            Text('Description: ${nonce.description}'),
//          ],
//        ),
//      ),
//    );
//  }
//
//}
