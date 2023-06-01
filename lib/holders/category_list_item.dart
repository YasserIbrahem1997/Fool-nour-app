import 'package:cached_network_image/cached_network_image.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../screens/subProducts/subProduct_CategoryWidget.dart';
import '../utils/commonMethod.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../models/api/order/createOrderModel.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../utils/prefrences.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CategoryListItem {

  Widget itemView(BuildContext context, GetDashboardCategories data) {
    double ITEMHEIGHT = 140;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_FromCategoryScreen(data.id, data.name)));
        },
        child: Card(
          elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            margin: EdgeInsets.all(5),
            color: MainHighlighter,
            child: Container(
                height: ITEMHEIGHT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: data.thumbnail != null ?
                      Container(
                        height: ITEMHEIGHT,
                        child: CachedNetworkImage(
                          imageUrl: data.thumbnail,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.filter_b_and_w),),
                        ),
                      ) : Container(),
                    )
                    ,
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            margin: EdgeInsets.only(right: 15),
                            child: Text(
                              data.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Header",
                                fontSize: 20,
                                color: BackgroundColor,
                              ),
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Container(
                            width: 140,
                            margin: EdgeInsets.only(right: 15),
                            child: Text(
                              data.count.toString() + " منتج",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Header",
                                fontSize: 16,
                                color: BackgroundColor,
                              ),
                            ),
                          ),
                          Container(child: Divider(color: BackgroundColor), width: 150,),
                          Container(
                            width: 140,
                            margin: EdgeInsets.only(right: 15),
                            child: Text(
                              data.description,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Header",
                                fontSize: 12,
                                color: BackgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
