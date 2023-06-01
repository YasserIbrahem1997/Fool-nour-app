import 'package:cached_network_image/cached_network_image.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/product/getProductsParent.dart';
import '../utils/commonMethod.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../models/api/order/createOrderModel.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../utils/prefrences.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CartWishList_ListItem {

  Widget getWishItem(BuildContext context,GetDashBoardProducts product, Function refresh) {
    return Container(
         margin: EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 20),
        child: GestureDetector(
          onTap: (){
            // Navigator.pushNamed(context, '/homeproductdetail', arguments: {'_product': product});
            // addORupdateCartProductsPref(Line_items(product.id, -1, 1, product  ));
            refresh();
          },
          child: Flex(
            direction: Axis.vertical,
            children: [
              product.images!=null&&product.images.length>0?
              ClipOval(
                  child:
                  CachedNetworkImage(
                    imageUrl: product.images[0].src,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
                    errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
                  )

              ):Container( color :Colors.transparent,width: 50, height: 50,),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: 70,
                    child: Text(
                      product.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: "Normal",
                        color: NormalColor,
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );

  }
}
