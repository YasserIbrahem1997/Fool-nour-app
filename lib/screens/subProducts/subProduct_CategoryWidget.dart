import '/http/customhttprequest.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/list_views/home_product_grid_view.dart';
import '/utils/appTheme.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class SubProduct_FromCategoryScreen extends StatefulWidget {
  int id;
  String title;
  SubProduct_FromCategoryScreen(this.id, this.title);
  @override
  _SubProduct_FromCategoryScreenState createState() => _SubProduct_FromCategoryScreenState();
}

class _SubProduct_FromCategoryScreenState extends State<SubProduct_FromCategoryScreen>   {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<GetDashBoardProducts>? subscreenProducts;

  @override
  void initState() {
    super.initState();

    CustomHttpRequest().getProductFromCategoryId(widget.id).then((value) {
      if (value != null) {
        subscreenProducts=value;
        setState(() {});
      }
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
                         maxLines: 2,
                         overflow: TextOverflow.visible,
                         textAlign: TextAlign.right,
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
              child: subscreenProducts!=null?Container(
                  child: ProductGridView().getGridView(context, subscreenProducts!.reversed.toList(), (){setState(() {});})
              ):Column(children: [ListTileShimmer(),ListTileShimmer(),ListTileShimmer()],)
            )

          ],
        ),
      ),
    );
  }


}
