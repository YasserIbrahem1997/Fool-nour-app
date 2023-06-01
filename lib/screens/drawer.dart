import 'package:cached_network_image/cached_network_image.dart';
import '/bloc/bloc_dashboard.dart';
import '/emuns/screenStatus.dart';
import '/screens/subProducts/subProduct_CategoryWidget.dart';
import '/utils/commonMethod.dart';
import '/utils/consts.dart';
import '/utils/paginator.dart';
import 'package:flutter/material.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SideDrawer extends StatefulWidget  {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer>   {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundColor,
        body: body(context)
    );
  }
  Widget body(BuildContext context) {
    // bool isLoadingMoreCategory = totalCategories != null ? totalCategories!.length < totalCategoryCount : true;

    return Container(
      color: BackgroundColor,
      child: NotificationListener(
          onNotification: _onScrollNotification,
          child: StreamBuilder(
            stream: dashboardBloc.getDashboardStreamController.stream,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> widgetList = []
                ..add(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        getHeaderOne(),

                        Container(child: Divider(color: NormalColor.withAlpha(100),), padding: EdgeInsets.only(right: 20, left: 20),),
                        // Row(children: [Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,), Text("Dashboard", style: TextStyle(color: MainHighlighter, fontSize: 18,))],),
                        getHeaderTwoItem(LocalLanguageString().home, () {
                          Navigator.pushReplacementNamed(context, "/home");
                        }),
                        // getHeaderTwoItem("Cart", () {
                        //   Navigator.pushNamed(context, '/cart', arguments: {'_showAppBar': true});
                        // }),
                        // getHeaderTwoItem("Favourites", () {
                        //   Navigator.pushNamed(context, '/wishlist');
                        // }),
                        // getHeaderTwoItem("Profile", () {
                        //   Navigator.pushNamed(context, '/userprofile');
                        // }),
                        // getHeaderTwoItem("Blogs", () {
                        //   Navigator.pushNamed(context, '/blogpost');
                        // }),


                        // getHeaderTwoCart(),
                        // getHeaderTwoFavourites(),
                        // getHeaderTwoProfile(),
                        // getHeaderTwoBlogPost(),

                        Container(child: Divider(color: NormalColor.withAlpha(50),), padding: EdgeInsets.only(right: 20, left: 20),),
                        Row(children: [Container(margin: EdgeInsets.all(7), color: MainHighlighter, width: 7, height: 25,), Text(LocalLanguageString().categories, style: TextStyle(color: MainHighlighter, fontSize: 18,))],),

                      ],
                    )
                )
                ..addAll(
                  allCategoriesWidget(),
                )
                ..add(
                  status==ScreenStatus.bussy?Center(child: JumpingDotsProgressIndicator(fontSize: 30.0,) ):Container(height: 40,)
                );
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widgetList.length,
                itemBuilder: (context, index) {
                  return widgetList[index];
                },
              );
            },
          )
      ),
    );
  }
  Widget getHeaderOne(){
    return Container(
        margin: EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height*0.19,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 120,
            ),
          ],
        )
    );
  }
  Widget getHeaderTwoItem(String title, Function() callBack){
    return  GestureDetector(
      onTap: callBack,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Normal",
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: NormalColor,
          ),
        ),
      ),
    );
  }
  // Widget getHeaderTwoCart(){
  //   return  GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, '/cart', arguments: {'_showAppBar': true});
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.only(left: 20,top: 10),
  //       child: Text(
  //         "Cart",
  //         style: TextStyle(
  //           fontFamily: "Normal",
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //           color: NormalColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget getHeaderTwoFavourites(){
  //   return  GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, '/wishlist');
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.only(left: 20,top: 10),
  //       child: Text(
  //         "Favourites",
  //         style: TextStyle(
  //           fontFamily: "Normal",
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //           color: NormalColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget getHeaderTwoProfile(){
  //   return  GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, '/userprofile');
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.only(left: 20,top: 10),
  //       child: Text(
  //         "Profile",
  //         style: TextStyle(
  //           fontFamily: "Normal",
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //           color: NormalColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget getHeaderTwoBlogPost(){
  //   return  GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, '/blogpost');
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.only(left: 20,top: 10),
  //       child: Text(
  //         "Blog Posts",
  //         style: TextStyle(
  //           fontFamily: "Normal",
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //           color: NormalColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  List<Widget> allCategoriesWidget( ) {
    return totalCategories!=null?totalCategories!.map((element) {
      return getListItem(
        imgUrl: element.thumbnail != null ? element.thumbnail : "",
        title: element.name,
        extendedTitle: "",
        description: "--",
        trailing: Icons.arrow_forward_ios,
        callback: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_FromCategoryScreen(element.id,element.name)));
        },
      );
    }).toList():[Container(child: CircularProgressIndicator(), alignment: Alignment.center,width: MediaQuery.of(context).size.width*0.36,)];

  }

  Widget getListItem({String? imgUrl, String? title, String? extendedTitle, String? description, IconData? trailing, Function()? callback}){

    return ListTile(
      onTap: callback,
      title: Container(
          width: 120,
          child: Row(
            children: [
              Container(
                  height: 55,
                  width: 55,
                  margin: EdgeInsets.only(right: 10),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imgUrl!,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
                      errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
                    ),
                  )
              ),Container(
                padding: EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width*0.4,
                child: Text(
                  title!,
                  style: TextStyle(
                    fontFamily: "Normal",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: NormalColor,
                  ),
                ),
              )
            ],
          )
      ),
      trailing: Icon(
        trailing,
        size: 13,
      ),
    );
  }

  ScreenStatus status=ScreenStatus.active;
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max &&  status==ScreenStatus.active) {
        print("scroll_end");
        status=ScreenStatus.bussy;
        dashboardBloc.refreshDashboards(true);
        loadNewDashboardData().then((value) {
          status=ScreenStatus.active;
          dashboardBloc.refreshDashboards(true);
        });
      }
    }
    return false;
  }

}