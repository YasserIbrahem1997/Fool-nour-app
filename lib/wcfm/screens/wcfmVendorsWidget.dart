import 'dart:ui';
import '/main.dart';
import '/utils/commonMethod.dart';
import '/utils/consts.dart';
import '/wcfm/holders/wcfmvendors_grid_item.dart';
import '/wcfm/models/api/vendor/getAllWcfmVendorsResponceModel.dart';
import '/wcfm/screens/subProducts/subProduct_WcfmVendorProductWidget.dart';
import '/wcfm/screens/subProducts/subVendors_WcfmOnlineVendorWidget.dart';
import '/wcfm/woohttprequest.dart';
import 'package:flutter/material.dart';
import '/list_views/home_category_horizontal_listview.dart';
import '/utils/appTheme.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class WcfmVendorScreen extends StatefulWidget  {

  @override
  _VendorScreenState createState() => new _VendorScreenState();
}
List<GetAllWcfmVendors>? wcfmVendors;

class _VendorScreenState extends State<WcfmVendorScreen> with TickerProviderStateMixin , CategoryButton{
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getHttpData();
  }
  getHttpData() async{
    WooHttpWcfmRequest().getWcfmVendors(await getRecentToken()).then((value) {
      if (value != null) {
        wcfmVendors!=value;

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
                    Text("Online Vendors",style: TextStyle(color: MainHighlighter, fontSize: 16, fontWeight: FontWeight.bold))
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
              onlineVendors(),

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

  Widget onlineVendors( ) {
    return GestureDetector(
      onTap: (){
        List<GetAllWcfmVendors> onlineVendors=[];
        wcfmVendors!.forEach((element) {
          if(!element.is_store_offline)
            onlineVendors.add(element);
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubVendor_WcfmOnlineVendorScreen(onlineVendors )));
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

    return wcfmVendors != null ? wcfmVendors!.map((item) {
      int rowIndex = wcfmVendors!.indexOf(item) % ITEM_INROW;
      int colIndex = (wcfmVendors!.indexOf(item) / ITEM_INROW).toInt();

      return rowIndex == 0 ? Container(
          height: 200,
          child:Row(
            children: []
              ..addAll(
                  List<Widget>.generate(ITEM_INROW, (index) {
                    int currentIndex = (colIndex * ITEM_INROW) + index;
                    GetAllWcfmVendors? currentItem = currentIndex < wcfmVendors!.length ? wcfmVendors![currentIndex] : null;
                    return currentItem == null ? Container() : Container(
                      width: (MediaQuery.of(context).size.width / ITEM_INROW) - 1,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_WcfmVendorProductScreen(currentItem.vendor_id, currentItem.vendor_shop_name)));
                        },
                        child: WcfmVendorListItem().itemView(currentItem,(){
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
