import 'dart:ui';
import '/main.dart';
import '/utils/commonMethod.dart';
import '/utils/consts.dart';
import '/dokan/holders/dokanvendors_grid_item.dart';
import '/dokan/models/api/vendor/getAllDokanVendorsResponceModel.dart';
import '/dokan/screens/subProducts/subProduct_DokanVendorProductWidget.dart';
import '/dokan/screens/subProducts/subVendors_DokanTrustedVendorWidget.dart';
import '/dokan/woohttprequest.dart';
import 'package:flutter/material.dart';
import '/list_views/home_category_horizontal_listview.dart';
import '/utils/appTheme.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class DokanVendorScreen extends StatefulWidget  {

  @override
  _VendorScreenState createState() => new _VendorScreenState();
}
List<GetAllDokanVendors>? dokanVendors;

class _VendorScreenState extends State<DokanVendorScreen> with TickerProviderStateMixin , CategoryButton{
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getHttpData();
  }
  getHttpData() async{
    WooHttpDokanRequest().getDokanVendors(await getRecentToken()).then((value) {
      if (value != null) {
        dokanVendors!=value;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = []
      ..add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
                  children: [
                    Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,),
                    Text("Trusted Vendors",style: TextStyle(color: MainHighlighter, fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
                  IconButton(
                    icon: Icon(Icons.list, color: NormalColor,),
                    onPressed: () {
                      prefs!.setBool(ISGRID, !(prefs!.getBool(ISGRID) ?? false)).then((isDone) {
                        setState(() {});
                      });
                    },
                  )
              ]),
              trustedVendors(),

              Divider(),
              Row(children: [Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,), Text("All Vendors",style: TextStyle(color: MainHighlighter, fontSize: 16, fontWeight: FontWeight.bold))] ,),

            ],
          )
      )..addAll(
          allVendorsWidget()
      );
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widgetList.length,
        itemBuilder: (context, index) {
          return widgetList[index];
        },
      ),
    );

  }

  Widget trustedVendors( ) {
    return GestureDetector(
      onTap: (){
        List<GetAllDokanVendors> trustedVendors=[];
        dokanVendors!.forEach((element) {
          if(element.trusted)
            trustedVendors.add(element);
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubVendor_DokanTrustedVendorScreen(trustedVendors )));
      },
      child: Container(
        child: Image.asset(
          'assets/bannervendor.jpg',
          width: MediaQuery.of(context).size.width,
          height: 150,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  List<Widget> allVendorsWidget( ) {
    int ITEM_INROW = prefs!.getBool(ISGRID)??true ?2:1;

    return dokanVendors != null ? dokanVendors!.map((item) {
      int rowIndex = dokanVendors!.indexOf(item) % ITEM_INROW;
      int colIndex = (dokanVendors!.indexOf(item) / ITEM_INROW).toInt();

      return rowIndex == 0 ? Container(
          height: 200,
          child:Row(
            children: []
              ..addAll(
                  List<Widget>.generate(ITEM_INROW, (index) {
                    int currentIndex = (colIndex * ITEM_INROW) + index;
                    GetAllDokanVendors? currentItem = currentIndex < dokanVendors!.length ? dokanVendors![currentIndex] : null;
                    return currentItem == null ? Container() : Container(
                      width: (MediaQuery.of(context).size.width / ITEM_INROW) - 1,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_DokanVendorProductScreen(currentItem.id, currentItem.store_name)));
                        },
                        child: DokanVendorListItem().itemView(currentItem,(){
                          setState(() {});
                        })
                      ),
                    );
                  }
                  )
              ),
          )
      ) : Container();
    }).toList() : [ProfileShimmer(),Divider(),ProfileShimmer()];
  }

}
