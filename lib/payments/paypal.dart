
import 'dart:async';
import 'dart:convert';
import '../models/checkoutSteps.dart';
import 'package:flutter/material.dart';
import '../payments/config.dart';
import '../utils/appTheme.dart';
import '../http/woohttprequest.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPaypal extends StatefulWidget {
  final String token;
  final String initalUrl;
  final String executeUrl;
  StepTwo shippmentLine;

  WebViewPaypal(this.token, this.initalUrl, this.executeUrl, this.shippmentLine);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewPaypal> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Stack(alignment: Alignment.topLeft,
          children: [
            // WebView(
            //   initialUrl: widget.initalUrl,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (WebViewController webViewController) {
            //     _controller.complete(webViewController);
            //   },
            //   // TODO(iskakaushik): Remove this when collection literals makes it to stable.
            //   // ignore: prefer_collection_literals
            //   javascriptChannels: <JavascriptChannel>[
            //     _toasterJavascriptChannel(context),
            //   ].toSet(),
            //   navigationDelegate: (NavigationRequest request) {
            //     if (request.url.startsWith(paypalRedirectUrls["return_url"])) {
            //       Uri uri = Uri.dataFromString(request.url); //converts string to a uri
            //       var payerId = uri.queryParameters["PayerID"]; // return value of parameter "param1" from uri
            //
            //       WooHttpRequest().paymentPaypalExecute(widget.token, payerId!, widget.executeUrl).then((value) {
            //         if(value) {
            //           Map<String,String> shippmentLineDetail= {
            //             "method_id":widget.shippmentLine.id.toString(),
            //             "method_title":widget.shippmentLine.title,
            //             "total":widget.shippmentLine.shippmentCost.toString(),
            //           };
            //
            //           // WooHttpRequest().putNewOrder(context, "paypal","PayPal",shippmentLineDetail).then((value) {
            //           //   Navigator.pushReplacementNamed(context, "/home");
            //           // });
            //         }
            //       });
            //       return NavigationDecision.prevent;
            //     }
            //     print('allowing navigation to $request');
            //     return NavigationDecision.navigate;
            //   },
            //   gestureNavigationEnabled: true,
            // ),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_back,
                    color: MainHighlighter,
                    size: 25,),
                )
            ),
          ],
        );
      }),
    );
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
  // }

}