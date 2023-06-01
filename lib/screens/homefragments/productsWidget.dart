import 'dart:ui';
import '/list_views/home_featured_horizontal_listview.dart';
import '/list_views/home_recent_horizontal_listview.dart';
import '/bloc/bloc_dashboard.dart';
import '/holders/product_list_item.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import '/models/api/product/getProductsParent.dart';
import '/screens/subProducts/subProduct_TopSellingWidget.dart';
import '/utils/paginator.dart';
import '/utils/prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '/emuns/screenStatus.dart';
import '/utils/commonMethod.dart';
import '/list_views/home_category_horizontal_listview.dart';
import '/WidgetHelper/filters.dart';
import '/main.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/consts.dart';
import '/utils/languages_local.dart';
import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => new _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with
        TickerProviderStateMixin,
        CategoryButton,
        RecentWidget,
        FeaturedWidget {
  String ad1 = '';
  String ad2 = '';
  String ad3 = '';
  String ad1_link = '';
  String ad2_link = '';
  String ad3_link = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Settings')
        .doc('Ads')
        .get()
        .then((value) {
      ad1 = value.get('ad1');
      ad2 = value.get('ad2');
      ad3 = value.get('ad3');
      ad1_link = value.get('ad1_link');
      ad2_link = value.get('ad2_link');
      ad3_link = value.get('ad3_link');

      setState(() {});
      print("ad2: " + ad2);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('sales_products');
    // print(sales_products);
    return Scaffold(
        body: Container(
      color: BackgroundColor,
      child: NotificationListener(
          onNotification: _onScrollNotification,
          child: StreamBuilder(
            stream: dashboardBloc.getDashboardStreamController.stream,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // bool isLoadingMore= (totalProducts!=null)?totalProducts!.length < totalProductCount:true;
              List<GetProductsParent> recents = getRecentlistPref();
              List<Widget> widgetList = []
                ..add(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    getSearchBarUI(),

                    // Container(
                    //   child: Image.network(
                    //     'https://nourrestaurant.com/wp-content/uploads/2022/12/banner.png',
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 190,
                    //     fit: BoxFit.fitWidth,
                    //   ),
                    // ),

                    Divider(),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(7),
                          color: MainHighlighter,
                          width: 7,
                          height: 25,
                        ),
                        Text(LocalLanguageString().categories,
                            style: TextStyle(
                                color: MainHighlighter,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    totalCategories != null
                        ? getCategoryUI(context, status)
                        : VideoShimmer(
                            isPurplishMode: false, isDarkMode: false),
                    Divider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ad1 != ''
                            ? GestureDetector(
                                onTap: () async {
                                  final uri = Uri.parse(ad1_link);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $ad1_link';
                                  }
                                },
                                child: Image.network(
                                  ad1,
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                ))
                            : Container(),
                        ad2 != ''
                            ? GestureDetector(
                                onTap: () async {
                                  final uri = Uri.parse(ad2_link);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $ad2_link';
                                  }
                                },
                                child: Image.network(
                                  ad2,
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                ))
                            : Container(),
                        ad3 != ''
                            ? GestureDetector(
                                onTap: () async {
                                  final uri = Uri.parse(ad3_link);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $ad3_link';
                                  }
                                },
                                child: Image.network(
                                  ad3,
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                ))
                            : Container(),
                      ],
                    ),
                    // Divider(),
                    // Row(children: [Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,), Text(LocalLanguageString().topselling,style: TextStyle(color: MainHighlighter, fontSize: 16, fontWeight: FontWeight.bold))] ,),
                    // topSellingProducts(),


                    // (recents != null && recents.length != 0)
                    //     ? Wrap(
                    //         children: [
                    //           Divider(),
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 margin: EdgeInsets.all(7),
                    //                 color: MainHighlighter,
                    //                 width: 7,
                    //                 height: 25,
                    //               ),
                    //               Text(LocalLanguageString().recents,
                    //                   style: TextStyle(
                    //                       color: MainHighlighter,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold))
                    //             ],
                    //           ),
                    //           getRecents(context, recents)
                    //         ],
                    //       )
                    //     : Container(),

                    (featured_products != null &&
                        featured_products!.length != 0)
                        ? Wrap(
                      children: [
                        Divider(),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(7),
                              color: MainHighlighter,
                              width: 7,
                              height: 25,
                            ),
                            Text(LocalLanguageString().featured,
                                style: TextStyle(
                                    color: MainHighlighter,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        getFeatured(context, featured_products!)
                      ],
                    )
                        : Container(),

                    (sales_products != null &&
                        sales_products!.length != 0)
                        ? Wrap(
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    color: MainHighlighter,
                                    width: 7,
                                    height: 25,
                                  ),
                                  Text('عروض',
                                      style: TextStyle(
                                          color: MainHighlighter,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              getFeatured(context, sales_products!)
                            ],
                          )
                        : Container(),

                    Divider(),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(7),
                          color: MainHighlighter,
                          width: 7,
                          height: 25,
                        ),
                        Text(LocalLanguageString().allproducts,
                            style: TextStyle(
                                color: MainHighlighter,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    // totalProducts != null ?getPopularProductUI():ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,)
                  ],
                ))
                ..addAll(allProductsWidget())
                ..add(status == ScreenStatus.bussy
                        ? Center(
                            child: Container(
                            child: CircularProgressIndicator(),
                            height: 30,
                            width: 30,
                          ))
                        : Container(
                            height: 40,
                          )
                    // isLoadingMore?Center(child: Container(child: CircularProgressIndicator(),height: 30,width: 30,) ):Container()
                    );
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widgetList.length,
                itemBuilder: (context, index) {
                  return widgetList[index];
                },
              );
            },
          )),
    ));
  }

  Widget topSellingProducts() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SubProduct_TopSellingScreen()));
      },
      child: Container(
        child: Image.asset(
          'assets/bannertopselling.jpg',
          width: MediaQuery.of(context).size.width,
          height: 150,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget otherBanner() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SubProduct_TopSellingScreen()));
      },
      child: Container(
        child: Image.asset(
          'assets/bannersale.jpg',
          width: MediaQuery.of(context).size.width,
          height: 150,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  List<Widget> allProductsWidget() {
    int ITEM_INROW = prefs!.getBool(ISGRID) ?? true ? 2 : 1;

    return totalProducts != null
        ? totalProducts!.map((item) {
            int rowIndex = totalProducts!.indexOf(item) % ITEM_INROW;
            int colIndex = (totalProducts!.indexOf(item) / ITEM_INROW).toInt();

            return rowIndex == 0
                ? Wrap(
                    children: [
                      Container(
                          height: 290,
                          child: Row(
                            children: []..addAll(
                                  List<Widget>.generate(ITEM_INROW, (index) {
                                int currentIndex =
                                    (colIndex * ITEM_INROW) + index;
                                GetDashBoardProducts? currentItem =
                                    currentIndex < totalProducts!.length
                                        ? totalProducts![currentIndex]
                                        : null;
                                return currentItem == null
                                    ? Container()
                                    : Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    ITEM_INROW) -
                                                1,
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/homeproductdetail',
                                                  arguments: {
                                                    '_product': currentItem
                                                  });
                                            },
                                            child: HomeProductListItem()
                                                .itemView(currentItem, () {
                                              setState(() {});
                                            })));
                              }).reversed),
                          )),
                      // (colIndex==4)?Container(
                      //   margin: EdgeInsets.only(top: 10,bottom: 5),
                      //   child: Column(
                      //     children: [
                      //       Divider(),
                      //       Row(children: [Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,), Text("Other Banner",style: TextStyle(color: MainHighlighter, fontSize: 16, fontWeight: FontWeight.bold))] ,),
                      //       otherBanner(),
                      //       SizedBox(height: 10,),
                      //       Divider(),
                      //     ],
                      //   ),
                      // ):Container()
                    ],
                  )
                : Container();
          }).toList()
        : [ListTileShimmer()];
  }

  // Widget getPopularProductUI( ) {
  //   bool isLoadingMore= (totalProducts!=null && totalProductCount!=0)?totalProducts.length < totalProductCount:true;
  //
  //    return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(8.0,),
  //           margin: EdgeInsets.only(top: 13.0,),
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             LocalLanguageString().popularproducts,
  //             textAlign: TextAlign.left,
  //             style: TextStyle(
  //               fontWeight: FontWeight.w900,
  //               fontSize: 18,
  //               letterSpacing: 0.27,
  //               fontFamily: "Normal",
  //               color: NormalColor,
  //             ),
  //           ),
  //         ),
  //         Container(
  //             child: StreamBuilder(
  //               stream: dashboardBloc.getDashboardStreamController.stream,
  //               initialData: totalProducts,
  //               builder: (BuildContext context, AsyncSnapshot snapshot) {
  //                 return totalProducts != null ? Column(
  //                   children: [
  //                     (prefs.getBool(ISGRID) ?? false) ? HomeProductListView(products: totalProducts,):HomeProductGridView(products: totalProducts,),
  //                     isLoadingMore ? Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,color: Colors.blue)) : Container(),
  //                   ],
  //                 ) : ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,);
  //               },
  //             )
  //         )
  //        ],
  //     ),
  //   );
  // }

  Widget getSearchBarUI() {
    return Padding(
        padding: EdgeInsets.only(top: 0, left: 18),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 6,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.search,
                            color: NormalColor,
                          )),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              labelText:
                                  LocalLanguageString().searchforproducts,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: NormalColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Normal",
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     child: IconButton(
            //       icon: Icon(
            //         Icons.list,
            //         color: NormalColor,
            //       ),
            //       onPressed: () {
            //         prefs!.setBool(ISGRID, !(prefs!.getBool(ISGRID) ?? false)).then((isDone) {
            //           setState(() {});
            //         });
            //       },
            //     ),
            //   ),
            // ), Expanded(
            //   flex: 1,
            //   child: Center(
            //     child: IconButton(
            //       icon: Icon(
            //         Icons.filter_list,
            //         color: NormalColor,
            //       ),
            //       onPressed: () {
            //         showModalBottomSheet(
            //           backgroundColor: BackgroundColor,
            //           context: context,
            //           builder: (sheetContext) =>
            //               BottomSheet(
            //                 builder: (_) => Filters(),
            //                 onClosing: () {},
            //               ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  ScreenStatus status = ScreenStatus.active;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max && status == ScreenStatus.active) {
        print("scroll_end");
        status = ScreenStatus.bussy;
        dashboardBloc.refreshDashboards(true);
        loadNewDashboardData().then((value) {
          status = ScreenStatus.active;
          dashboardBloc.refreshDashboards(true);
        });
      }
    }
    return false;
  }
}
