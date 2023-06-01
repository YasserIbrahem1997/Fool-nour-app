import 'package:cached_network_image/cached_network_image.dart';
import '../holders/home_recent_list_item.dart';
import '../models/api/product/getProductsParent.dart';
import '../screens/subProducts/subProduct_CategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import 'package:progress_indicators/progress_indicators.dart';

class RecentWidget {

  Widget getRecents(BuildContext context, List<GetProductsParent> recents) {

    double itemHeight =100;
    double itemPadding=2;
    return Container(
        height: itemHeight,
        child: recents!=null? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: recents.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeRecentListItem(context, recents[index], itemHeight, itemPadding).getRecentItem( );
            }
        ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,)
    );
  }

}