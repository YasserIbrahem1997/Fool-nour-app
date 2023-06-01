import 'dart:async';

import '../bloc/bloc_dashboard.dart';
import '../http/customhttprequest.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../utils/commonMethod.dart';
import '../utils/paginator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/appTheme.dart';
import '../utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// int productPage=1;
// List<GetProducts> products;
//
// int categoryPage=1;
// List<GetCategories> categories;

List<GetDashBoardProducts>? featured_products;
List<GetDashBoardProducts>? sales_products;
List<GetDashBoardProducts>? top_selling_products;
List<GetDashBoardProducts>? totalProducts;
List<GetDashboardCategories>? totalCategories;
// int totalProductCount = 0;
// int totalCategoryCount = 0;
String currencyCode = "";
// String currencySymbol;

class SplashWidget extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = new Duration(milliseconds: 3500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (prefs != null) {
      if (prefs!.getBool(ISFIRSTOPEN) ?? true)
        Navigator.pushReplacementNamed(context, "/home");
      else
        Navigator.pushReplacementNamed(context, "/home");
    } else
      Navigator.pushReplacementNamed(context, "/home");
  }

  Future getPrefences() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setBool(DARKTHEME, true);
    await prefs!.setString(LANGUAGE, "ar");

    return null;
  }

  @override
  void initState() {
    super.initState();
    CustomHttpRequest().getDashboard(dashboard_page).then((value) {
      if (value != null) {
        refreshNewDashboardData(value);
        dashboardBloc.refreshDashboards(true);
      }
    });

    // wooHttpRequest.getProducts().then((value) {
    //   refreshProducts(value);
    //   productBloc.refreshProducts(products);
    // });
    //
    // wooHttpRequest.getCategories().then((value) {
    //   refreshCategories(value);
    //   categoryBloc.refreshCategories(categories);
    // });
    //
    // wooHttpRequest.getTotalCategoryCount().then((value) {
    //   totalCategoryCount=value;
    // });
    //
    // wooHttpRequest.getSettings().then((value) {
    //   currencyCode=value;
    // });


  }

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      getPrefences().then((value) {
        setState(() {});
      });
      return Scaffold(backgroundColor: Colors.white, body: Container());
    } else {
      startTime();

      return Scaffold(
          backgroundColor: BackgroundColor,
          body: Container(
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [grad_start,grad_end],
              //     )
              // ),
              child: Center(
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 150,
                      ),
                      // Text(
                      //   "Wooflux for woocommerce stores ",
                      //   style: TextStyle(
                      //     color: NormalColor,
                      //     fontSize: 18.0,
                      //     overflow: TextOverflow.ellipsis,
                      //     fontFamily: "Header",
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Center(
                          child: TypewriterAnimatedTextKit(
                              isRepeatingAnimation: false,
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                                ". . . . . . . . . . . . ",
                                ". . . . . . . . . . . . ",
                              ],
                              textStyle: TextStyle(
                                  color: NormalColor,
                                  fontSize: 28.0,
                                  fontFamily: "Normal")),
                        ),
                        //  Text(
                        //  "©2009-2019 Applipie All Rights Reserved",
                        //    style: TextStyle(
                        //      color: NormalColor,
                        //      fontSize: 14.0,
                        //      overflow: TextOverflow.ellipsis,
                        //      fontFamily: "Header",

                        //    ),
                        //  ),
                      ],
                    )),
              ],
            ),
          )));
    }
  }

  // getCategories() async {
  //   WooHttpRequest().getCategories(++categoryPage).then((value) {categoryBloc.refreshCategories(value);});
  //
  // categories =await WooHttpRequest().getCategories();
  // categoryBloc.refreshCategories(categories);
  // print(categories);
  // }
  // getOrders() async {
  //   orders =await WooHttpRequest().getOrders();
  //   print(orders);
  // }
  //
  // getCoupon() async {
  //   coupons =await WooHttpRequest().getCoupon();
  //   print(coupons);
  // }
  //

  // getPaymentGatewayMethod() async {
  //   paymentGateway =await WooHttpRequest().getPaymentGatways();
  //   print(paymentGateway);
  // }

}
