import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../http/customhttprequest.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/orderButton.dart';
import '../bloc/bloc_order.dart';
import '../emuns/orderType.dart';
import '../models/api/order/getOrders.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:collection/collection.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<OrdersScreen> with OrderButton {
  List<GetDashBoardProducts> _pro = [];

  @override
  void initState() {
    super.initState();
    WooHttpRequest().getOrders().then((ordvalue) {
      orders = ordvalue;
      List<int> productIds = [];
      orders!.forEach((element) {
        if (element != null && element.line_items.length > 0)
          productIds.add(element.line_items[0].product_id);
      });
      print(productIds);
      CustomHttpRequest().getProductsFromId(productIds).then((provalue) {
        _pro = provalue;
        orderBloc.refreshOrders(ordvalue);
      });
    });
  }

  double boxSize = 70;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    return Scaffold(
        backgroundColor: BackgroundColor,
        body: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 13,
                  child: ListView(children: [
                    Container(
                      color: BackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                // final snackBar = SnackBar(
                                //   /// need to set following properties for best effect of awesome_snackbar_content
                                //   elevation: 0,
                                //   behavior: SnackBarBehavior.floating,
                                //   backgroundColor: Colors.transparent,
                                //   content: AwesomeSnackbarContent(
                                //     title: 'مرحبا عميلنا العزيز ',
                                //     message:
                                //     'This is an example error message that will be shown in the body of snackbar!',
                                //
                                //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                //     contentType: ContentType.failure,
                                //   ),
                                // );
                                //
                                // ScaffoldMessenger.of(context)
                                //   ..hideCurrentSnackBar()
                                //   ..showSnackBar(snackBar);
                                SnackBar(content: Text("lshx hgtg"));
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: MainHighlighter,
                                  size: 25,
                                ),
                              )),
                          Text(
                            LocalLanguageString().orderhistory,
                            style: TextStyle(
                              color: MainHighlighter,
                              fontSize: 20.0,
                              fontFamily: "Header",
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container()
                        ],
                      ),
                    ),
                    // getSearchBarUI(),
                    // Container(
                    //   height: 50,
                    //   child:  StreamBuilder(
                    //     stream: orderBloc.selectOrderTypeStreamController.stream,
                    //     initialData: OrderStatus.any,
                    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //       return snapshot.data!=null? getOrderTypes(snapshot.data):
                    //       Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,color: MainHighlighter));
                    //     },
                    //   ),
                    // ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                      stream: orderBloc.getOrderStreamController.stream,
                      initialData: orders,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return (snapshot.data != null)
                            ? Column(
                                children:
                                    List<GetOrderResponce>.from(snapshot.data)
                                        .map((data) => _item(data))
                                        .toList())
                            : Container(
                                child: JumpingDotsProgressIndicator(
                                  fontSize: 30.0,
                                  color: MainHighlighter,
                                ),
                              );
                      },
                    )
                  ]))
            ],
          ),
        ));
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.search,
                        color: NormalColor,
                      )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontFamily: "Normal",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: NormalColor,
                        ),
                        decoration: InputDecoration(
                          labelText: LocalLanguageString().searchforproducts,
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Normal",
                            color: NormalColor,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: NormalColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Normal",
                          ),
                        ),
                        onChanged: (value) {
                          List<GetOrderResponce> _orders = [];

                          orders!.forEach((data) {
                            if (data.order_key
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                (data.billing.first_name! == null
                                        ? ""
                                        : data.billing.first_name!
                                            .toLowerCase())
                                    .contains(value.toLowerCase())) {
                              _orders.add(data);
                            }
                          });
                          orderBloc.refreshOrders(_orders);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget _item(GetOrderResponce orderResponce) {
    GetDashBoardProducts? thisproduct = _pro.firstWhereOrNull(
        (element) => element.id == orderResponce.line_items[0].product_id);
    return Column(
      children: [
        Row(
          children: [
            (orderResponce.line_items != null &&
                    orderResponce.line_items.length > 0)
                ? Container(
                    padding: EdgeInsets.all(5),
                    child: (thisproduct != null)
                        ? thisproduct.images.length == 0
                            ? Container()
                            :
                            // Image.network(
                            //    thisproduct.images[0].src,
                            //   height: 80,
                            //   width: 80,
                            //   fit: BoxFit.cover,
                            //   errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {return Icon(Icons.image, color: MainHighlighter, size: 25,);},
                            // )
                            CachedNetworkImage(
                                imageUrl: thisproduct.images[0].src,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                    child: JumpingDotsProgressIndicator(
                                  fontSize: 20.0,
                                  color: MainHighlighter,
                                )),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(Icons.filter_b_and_w),
                                ),
                              )
                        : Container(width: 80.0, height: 80.0),
                  )
                : Container(),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "طلب رقم #${orderResponce.id}".toUpperCase(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: NormalColor,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        LocalLanguageString().charges +
                            ": ${orderResponce.total} $currencyCode",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: NormalColor,
                            fontSize: 15,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "الحالة: ${orderResponce.status == 'any' ? 'الكل' : orderResponce.status == 'pending' ? 'في الإنتظار' : orderResponce.status == 'processing' ? 'في التحضير' : orderResponce.status == 'completed' ? 'مكتمل' : ''}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: NormalColor,
                            fontSize: 14,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
