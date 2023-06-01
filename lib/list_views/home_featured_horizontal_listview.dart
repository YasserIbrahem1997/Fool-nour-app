import 'package:cached_network_image/cached_network_image.dart';
import '../holders/home_featured_list_item.dart';
import '../holders/home_recent_list_item.dart';
import '../models/api/product/getProductsParent.dart';
import '../screens/subProducts/subProduct_CategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FeaturedWidget {

  Widget getFeatured(BuildContext context, List<GetProductsParent> featured) {

    return Container(
        height: 250,
        child: featured!=null? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            itemCount: featured.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeFeaturedListItem().getFeaturedItem(context, featured[index]);
            }
        ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,)
    );
  }

}