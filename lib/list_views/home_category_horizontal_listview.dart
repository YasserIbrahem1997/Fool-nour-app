import 'package:cached_network_image/cached_network_image.dart';
import '../emuns/screenStatus.dart';
import '../holders/home_category_list_item.dart';
import '../screens/subProducts/subProduct_CategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CategoryButton {

  double itemHeight =125;
  double itemPadding=2;
  Widget getCategoryUI(BuildContext context, ScreenStatus status) {
    // bool isLoadingMoreCategory = totalCategories != null ? totalCategories!.length < totalCategoryCount : true;

    return Container(
        height: 150,
        child: totalCategories!=null? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: totalCategories!.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                  children: [HomeCategoryListItem(context, totalCategories![index],itemHeight,itemPadding).getCategoryItem(),
                    if (status==ScreenStatus.bussy && index==totalCategories!.length-1)
                      Center(child: Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,) , margin: EdgeInsets.only(right: 20),))
                    else if(index==totalCategories!.length-1)
                      Container(width: 40,)
                    else
                      Container()
                    // (isLoadingMoreCategory && index==totalCategories!.length-1) ? Container(child: JumpingDotsProgressIndicator(fontSize: 30.0,)) : Container(),
                  ]
              );
            }
        ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,)
    );
  }

}