import '/http/customhttprequest.dart';
import '/http/woohttprequest.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import '/utils/commonMethod.dart';
import '/dokan/woohttprequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/list_views/home_product_grid_view.dart';
import '/utils/appTheme.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class SubProduct_DokanVendorProductScreen extends StatefulWidget {
  int vendorId;
  String title;
  SubProduct_DokanVendorProductScreen(this.vendorId, this.title);
  @override
  _SubProduct_VendorProductScreenState createState() => _SubProduct_VendorProductScreenState();
}

class _SubProduct_VendorProductScreenState extends State<SubProduct_DokanVendorProductScreen>   {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<GetDashBoardProducts>? vendorProducts;

  @override
  void initState() {
    super.initState();
    getRecentToken().then((token) {
      WooHttpDokanRequest().getDokanVendorProducts(token,widget.vendorId).then((value) {
        if (value != null) {
          vendorProducts!=value;
          setState(() {});
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: BackgroundColor,
        key: _scaffoldKey,
        body: SafeArea(
          child: screen(),
        )
    );
  }


  Widget screen( ) {

    return Container(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.arrow_back,
                            color: MainHighlighter,
                            size: 25,
                          ),
                        )
                    ),
                   Container(
                     width: MediaQuery.of(context).size.width*0.6,
                     child: Text(
                       widget.title,
                       maxLines: 1,
                       overflow: TextOverflow.visible,
                       textAlign: TextAlign.center,
                       style: TextStyle(color: MainHighlighter,
                         fontSize: 20.0,
                         fontFamily: "Header",
                         letterSpacing: 1.2,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   Container(),

                  ],
                ),
              )
          ),
          Expanded(
            flex: 10,
            child: vendorProducts!=null?Container(
              child: ProductGridView().getGridView(context, vendorProducts!, (){setState(() {});})
            ):Column(children:  [ProfileShimmer(),Divider(),ProfileShimmer()],)
          )

        ],
      ),
    );
  }


}
