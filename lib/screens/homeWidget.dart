import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import '../bloc/bloc_dashboard.dart';
import '../bloc/bloc_order.dart';
import '../emuns/apptypes.dart';
import '../http/customhttprequest.dart';
import '../http/woohttprequest.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/order/getOrders.dart';
import '../screens/drawer.dart';
import '../dokan/screens/dokanVendorsWidget.dart';
import '../utils/paginator.dart';
import '../wcfm/screens/wcfmVendorsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../main.dart';
import '../screens/homefragments/cartWidget.dart';
import '../screens/homefragments/categoryWidget.dart';
import '../screens/homefragments/productsWidget.dart';
import '../screens/homefragments/settingwidget.dart';
import '../utils/appTheme.dart';
import '../utils/consts.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

 class _HomeScreenState extends State<HomeScreen>   {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enabled = false; // tracks if drawer should be opened or not
  List<GetDashBoardProducts> _pro = [];

  @override
  void initState() {
    super.initState();
    prefs!.setBool(ISFIRSTOPEN, false);

    Firebase.initializeApp().whenComplete(() {
      print("completed initializeApp");
      setState(() {});
    });
    WooHttpRequest().getOrders().then((ordvalue) {
      List<int> productIds = [];
      ordvalue!.forEach((element) {
        if (element != null && element.line_items.length > 0)
          productIds.add(element.line_items[0].product_id);

      });
      print(productIds);
      CustomHttpRequest().getProductsFromId(productIds).then((provalue) {
        _pro = provalue;
        orderBloc.refreshOrders(ordvalue);
        print(" thiiiiiiiiiiiiiiiis ${provalue.length}");
        if( provalue.isNotEmpty){
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'مرحبا عميلنا العزيز ',
              message:
              'This is an example error message that will be shown in the body of snackbar!',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

        }

      });
    });
   // FirebaseFirestore.instance.collection('versions').doc("updatedVersion").get().then((value) {
   //   bool updateNow=value.data()!["updateNow"];
   //   String versionandroid=value.data()!["versionandroid"];
   //   String versionios=value.data()!["versionios"];
   //   if(updateNow)
   //   {
   //     PackageInfo.fromPlatform().then((packageInfo){
   //       String versionName = packageInfo.version;
   //       String versionCode = packageInfo.buildNumber;
   //
   //       if (
   //       ((Platform.isIOS &&versionName!=versionios) || (Platform.isAndroid &&versionName!=versionandroid))
   //       ){
   //         Navigator.pushNamed(context, '/update' );
   //       }
   //     });
   //   }
   // });

  }
  @override
  Widget build(BuildContext context) {
    // WooHttpRequest().getDashboard(dashboard_page).then((value) {
    //   dashboardBloc.refreshDashboards(value);
    // });

    return DefaultTabController(  // Added
      length: TabBarCount,  // Added
      initialIndex: 0, //Added
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: SideDrawer()),
        backgroundColor: BackgroundColor,
        bottomNavigationBar: navTabItem(),
        body: SafeArea(
          child:body(),
        )
      )
    );
  }

  Widget body() {
    List<Widget> tabChilds=[
      ProductScreen(),
      CategoryScreen(),
    ];

    if (APPTYPE == AppType.WCFM )
      tabChilds.add(WcfmVendorScreen());
    if (APPTYPE == AppType.Dokan )
      tabChilds.add(DokanVendorScreen());

    tabChilds.addAll(
      [
        CartScreen(false),
        SettingScreen(() {
          setState(() {});
        }),
      ]
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         

          Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  color: BackgroundColor,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              drawerButtonIcon(() {
                                _scaffoldKey.currentState!.openDrawer();
                              }, Icons.apps),
                              Text('مطعم ',style:  TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                              Text('نور', style:  TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),),


                              // delme
                            ],
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //   ],
                      // ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 50, top: 10),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 75,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
          Expanded(
            flex: 10,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tabChilds
            ),
          ),
        ],
      ),
    );
  }

 

}
