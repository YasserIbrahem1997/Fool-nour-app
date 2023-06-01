import 'package:cached_network_image/cached_network_image.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import '/dokan/models/api/vendor/getAllDokanVendorsResponceModel.dart';
import 'package:flutter/material.dart';
import '/WidgetHelper/CustomIcons.dart';
import '/models/api/order/createOrderModel.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';
import '/utils/prefrences.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DokanVendorListItem {
  Widget itemView(GetAllDokanVendors data , Function refresh) {

    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(5),
                width: double.infinity,
                child:data.banner!=null?ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      imageUrl: data.banner,
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
                    )
                ):Container(height: 80,width: 80,)
            ),
          ),
          Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            imageUrl: data.gravatar,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
                            errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
                          )
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        width: 112,
                        child: Text(
                          data.store_name==null?"":data.store_name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            letterSpacing: 0.27,
                            color: NormalColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Trusted "),
                          data.trusted?Icon(Icons.verified,color: MainHighlighter):Icon(Icons.verified_outlined,color: NormalColor,)
                        ],
                      ),
                      // Container(height: 2,width: double.infinity,color: SecondaryHighlighter,)
                    ],
                  )
                ],
              )
          ),
          Container(child: Divider(color: NormalColor,),padding: EdgeInsets.all(5),)
        ],
      ),
    );

  }
}
