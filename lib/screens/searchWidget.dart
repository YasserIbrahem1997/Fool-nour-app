import 'dart:ui';
import '../http/customhttprequest.dart';
import '../list_views/search_product_grid_view.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '../bloc/bloc_searchProduct.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SearchScreen extends StatefulWidget  {

@override
_SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int totalProductCount = 0;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: BackgroundColor,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                )
            ),
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

                            child: Icon(Icons.arrow_back,
                              color: MainHighlighter,
                              size: 25,),
                          )
                      ),
                      Text(
                        LocalLanguageString().searchforproducts,
                        style: TextStyle(
                          color: MainHighlighter,
                          fontSize: 20.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Header",
                          letterSpacing: 1.2,
                        ),
                      ),
                      Container(),

                    ],
                  ),
                )
            ),
            Expanded(
                flex: 13,
                child: Container(
                    child: ListView(
                      children: [
                        getSearchBarUI(),
                        Divider(),
                        getSearchProducts(),
                      ],
                    )
                )
            )

          ],
        ),
      ),
    );

  }


  List<GetDashBoardProducts> searchedProducts=[];
  Widget getSearchProducts() {
     return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0,),
            margin: EdgeInsets.only(top: 13.0,),
            alignment: Alignment.centerLeft,
            child: Text(
              LocalLanguageString().searchforproducts,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 0.27,
                fontFamily: "Normal",
                color: NormalColor,
              ),
            ),
          ),
          Container(
              child: StreamBuilder(
                stream: searchProductBloc.getSearchProductStreamController.stream,
                initialData: searchedProducts,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data != null ?
                  HomeProductSearchView().getGridView(context, snapshot.data, (){setState(() {});}) :
                  Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,color: SecondaryHighlighter,));
                },
              )
          ),
         ],
      ),
    );
  }


  Widget getSearchBarUI() {
    TextEditingController searchTextController = new TextEditingController();
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 60,
              height: 60,
              child: Icon(
                Icons.search,
                color: NormalColor,
              )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: searchTextController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontFamily: "Normal",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: NormalColor,
                ),
                decoration: InputDecoration(
                  labelText: LocalLanguageString().searchforproducts,
                  border: InputBorder.none,
                  helperStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Normal",
                    color: NormalColor,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: NormalColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Normal",
                  ),
                ),
                onEditingComplete: ( ){
                  searchProductBloc.refreshSearchProducts(null);
                  CustomHttpRequest().getSearchProducts(searchTextController.text).then((value) {
                    searchProductBloc.refreshSearchProducts(value);
                  });
                  print("");
                },
                onChanged: (value) {
                },
              ),
            ),
          ),

        ],
      ),
    );
  }

}
