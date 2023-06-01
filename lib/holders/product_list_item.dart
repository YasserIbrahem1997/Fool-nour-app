import 'package:cached_network_image/cached_network_image.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../utils/commonMethod.dart';
import 'package:flutter/material.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../models/api/order/createOrderModel.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../utils/prefrences.dart';
import 'package:collection/collection.dart';
class HomeProductListItem {

  Widget itemView(GetDashBoardProducts data,Function refresh) {
     bool isCartItem=getCartProductsPref().firstWhereOrNull((element) => element.product_id==data.id  )!=null;
     bool isWishListed=getWishlistPref().firstWhereOrNull((element) => element.id==data.id )!=null;

    return  Container(
      margin: EdgeInsets.all(2),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[

          Expanded(
              flex: 7,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                      width: double.infinity,
                      child:data.images.length>0?ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                         CachedNetworkImage(
                           imageUrl: data.images[0].src,
                           // height: 90,
                           // width: 90,
                           imageBuilder: (context, imageProvider) => Container(
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                   image: imageProvider,
                                   fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           placeholder: (context, url) => Center(child: Container(child: CircularProgressIndicator(),height: 30,width: 30,) ),//JumpingDotsProgressIndicator(fontSize: 20.0,)
                           errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
                         )
                      ):Container(height: 80,width: 80,)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     (data.on_sale&& data.sale_price!=null && data.sale_price!="")?Container(
                          decoration: BoxDecoration(
                              color: MainHighlighter,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0),
                              )
                          ),
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          child: Text(
                            "-"+getPercentageOnsale(double.parse(data.sale_price),double.parse(data.regular_price)).toString()+"%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Header",
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: BackgroundColor,
                            ),
                          )
                      ):Container(width: 40,height: 40,),

                      InkWell(
                        onTap: (){
                          if(isWishListed)
                            removeFromWishList(data.id);
                          else
                            addWhishlistPref(data);
                          refresh();
                        },
                        child: Icon(isWishListed?Icons.favorite:Icons.favorite_border,
                          color: MainHighlighter,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),

          Expanded(
            flex: 5,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
//                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          data.title==null?"":data.title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          maxLines: 4,
                          style: TextStyle(
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.27,
                            color: MainHighlighter,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: getReviews(data.average_rating,data.rating_count),
                      ),
                      SizedBox(height: 5,),
                      // Container(
                      //   padding: EdgeInsets.all(3),
                      //   child: Text(
                      //     LocalLanguageString().totalsales+" :"+"  ${data.total_sales}",
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontFamily: "Normal",
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 12,
                      //       color: MainHighlighter,
                      //     ),
                      //   ),
                      // ),
                      Container(
                          padding: EdgeInsets.all(2),
                          child: Row(
                            children: [
                              Text(
                                LocalLanguageString().cost+""+" ${data.price} ${currencyCode==null?"":currencyCode}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Normal",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MainHighlighter,
                                ),
                              ),
                              data.on_sale?
                              data.sale_price!=null?Text(
                                " ${data.sale_price} ${currencyCode==null?"":currencyCode}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Normal",
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 10,
                                  color: NormalColor.withOpacity(0.5),
                                ),
                              ):Container()
                                  :Container()
                            ],
                          )
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: GestureDetector(
                //     onTap: (){
                //       if(isCartItem)
                //         delCartProductsPref(data.id);
                //       else
                //         addORupdateCartProductsPref(Line_items(data.id, -1, 1, data));
                //       refresh();
                //     },
                //     child: Image.asset(
                //       isCartItem?"assets/removecart.png":"assets/addcart.png",width: 25,height: 25,color:isCartItem?NormalColor:MainHighlighter,
                //     ),
                //
                //   ),
                // )
              ],
            )
          )
        ],
      ),
    );
  }
}
