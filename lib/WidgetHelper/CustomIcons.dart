import '../emuns/apptypes.dart';
import '../utils/consts.dart';
import 'package:flutter/material.dart';
import '../utils/appTheme.dart';

Widget drawerButtonIcon(Function() callBack,IconData icon) {
  return GestureDetector(
      onTap: callBack,
      child: Container(
        color: BackgroundColor,
        padding: EdgeInsets.all(5),
        height: 60,
        width: 60,
        child: Icon(
          icon,
          color: MainHighlighter,
          size: 30,
        ),
      )
  );
}
Widget navTabItem() {
  double iconSize = 28;
  List<Widget> tabList = [
    Tab(
      icon: Image.asset("assets/nav_home.png", width: iconSize, height: iconSize, color: MainHighlighter,), //,color: NormalColor,
    ),
    Tab(
      icon: Image.asset("assets/nav_category.png", width: iconSize, height: iconSize, color: MainHighlighter),
    )
  ];
  if (APPTYPE == AppType.WCFM || APPTYPE == AppType.Dokan)
    tabList.add(Tab(
      icon: Image.asset("assets/nav_vendor.png", width: iconSize, height: iconSize, color: MainHighlighter),
    ));
  tabList.addAll(
    [
      Tab(
        icon: Image.asset("assets/nav_cart.png", width: iconSize, height: iconSize, color: MainHighlighter),
      ),
      Tab(
        icon: Image.asset("assets/nav_setting.png", width: iconSize, height: iconSize, color: MainHighlighter),
      ),
    ]
  );

  return TabBar(
    labelColor: MainHighlighter,
    unselectedLabelColor: MainHighlighter,
//    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: EdgeInsets.all(5.0),
    indicatorColor: SecondaryHighlighter,
    indicatorSize: TabBarIndicatorSize.label,
    tabs: tabList,
  );
}



Widget getReviews( average_rating,rating_count){
  int rating =double.parse(average_rating).floor();
  return Row(
    children: <Widget>[
      rating==0?  Row(
        children: List.generate(5-rating, (index)  {
          return Icon(
            Icons.star_border,
            size: 15,
            color: SecondaryHighlighter,
          );
        }),
      ):Row(
          children: []..addAll(
              List.generate(rating, (index)  {
                return Icon(
                  Icons.star,
                  size: 15,
                  color: SecondaryHighlighter,
                );
              })
          )..addAll(
              List.generate(5-rating, (index)  {
                return Icon(
                  Icons.star_border,
                  size: 15,
                  color: SecondaryHighlighter,
                );
              })
          )..add( Text(
            '  ( ${rating_count} )',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Normal",
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: NormalColor,
            ),
          ),)
      ),
    ],
  );
}
