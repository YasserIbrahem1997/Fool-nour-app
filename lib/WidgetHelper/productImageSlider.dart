import 'package:cached_network_image/cached_network_image.dart';
import '../models/api/product/getProductsParent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/bloc_productDetail.dart';
import '../utils/appTheme.dart';
import 'package:progress_indicators/progress_indicators.dart';


Widget getImageProductSlider(BuildContext context,List<Images> images ) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      images != null && images.length > 0 ?
      StreamBuilder(
        stream: productDetailBloc.selectCarouselStreamController.stream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: Container(
              height: MediaQuery.of(context).size.height*0.57,
              // margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            child: JumpingDotsProgressIndicator(fontSize: 30.0, color: NormalColor,),
                          ),
                          CachedNetworkImage(
                            imageUrl: images[snapshot.data].src,
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
                        ],
                      )

                    ],
                  )
              ),
            ),
          );
        },
      ) : Container(
        height: MediaQuery.of(context).size.height * 0.25,
      ),
      images != null && images.length > 0 ?
      Container(
        margin: EdgeInsets.all(6),
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: images.map((item) =>
              GestureDetector(
                  onTap: () {
                    productDetailBloc.selectCarouselIndex(images.indexOf(item));
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: NormalColor, width: 1),
                          color: BackgroundColor
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: JumpingDotsProgressIndicator(fontSize: 30.0,color: NormalColor,),
                          ),
                          CachedNetworkImage(
                            imageUrl: item.src,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 70,
                              height: 80,
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
                        ],
                      )

                  )
              )).toList(),
        ),
      ) :
      Container(
        height: 80,
      )
    ],
  );
}