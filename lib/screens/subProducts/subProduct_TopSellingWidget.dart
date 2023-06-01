import '/http/customhttprequest.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import '/screens/splashWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/list_views/home_product_grid_view.dart';
import '/utils/appTheme.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class SubProduct_TopSellingScreen extends StatefulWidget {
  SubProduct_TopSellingScreen( );
  @override
  _SubProduct_TopSellingScreenState createState() => _SubProduct_TopSellingScreenState();
}

class _SubProduct_TopSellingScreenState extends State<SubProduct_TopSellingScreen>   {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
                       "Top Selling",
                       maxLines: 1,
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.visible,
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
            child: top_selling_products!=null?Container(
              child: ProductGridView().getGridView(context, top_selling_products!, (){setState(() {});})
            ):Column(children: [ListTileShimmer(),ListTileShimmer(),ListTileShimmer()],)
          )

        ],
      ),
    );
  }


}
