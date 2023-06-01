import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/bloc_order.dart';
import '../../../cubit/get_order_cubit.dart';
import '../../../cubit/get_ordere_statrs.dart';
import '../../../http/customhttprequest.dart';
import '../../../http/woohttprequest.dart';
import '../../../models/api/dashboard/getDashboardProducts.dart';
import '../../../models/api/order/getOrders.dart';
import '../../../respons.dart';
import '../../../utils/appTheme.dart';
import '../../../utils/languages_local.dart';
import '../../splashWidget.dart';
import 'all_widget_dashbord/header.dart';
import 'all_widget_dashbord/my_files.dart';
import 'all_widget_dashbord/recent_files.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({Key? key}) : super(key: key);

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  List<GetDashBoardProducts> _pro = [];
  List<GetOrderResponce>? AllOrders;

  // Future<List<GetOrderResponce>> aftchOrdare() async {
  //   List<GetOrderResponce> tempListResponce = [];
  //   var url = Uri.parse("https://nourrestaurant.com/wp-json/wc/v3/orders");
  //   var respons = await http.get(url);
  //   var responsBody = jsonDecode(respons.body);
  //   print(responsBody);
  //   for (var data in responsBody) {
  //     tempListResponce.add(GetOrderResponce(
  //         data["id"],
  //         data["order_key"],
  //         data["status"],
  //         data["total"],
  //         data['total_tax'],
  //         data ["customer_id"],
  //         data ["payment_method_title"],
  //         data ["transaction_id"],
  //         data ["billing"],
  //         data ["shipping"],
  //         data ["line_items"]));
  //   }
  //   print( " thiiiiiiis $tempListResponce");
  //   return tempListResponce;
  // }

  @override
  void initState() {
    // this.aftchOrdare();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<GetAllOrderCubit>();
      cubit.fetchDataOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    var getAllOrderCubit =
        BlocProvider.of<GetAllOrderCubit>(context, listen: true);
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Container(
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
                        LocalLanguageString().dashbord,
                        style: TextStyle(
                          color: MainHighlighter,
                          fontSize: 20.0,
                          fontFamily: "Header",
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                )),
            Expanded(
                flex: 13,
                child: MyFiles()),
          ],
        ),
      ),
    );
  }

  Widget _item(GetOrderResponce orderResponce) {
    GetDashBoardProducts? thisproduct = _pro.firstWhere(
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

const primaryColor = Color(0xFF081730);
const secondaryColor = Color(0xFF232A4E);
const bgColor = Color(0xFF03112D);

const defaultPadding = 16.0;
