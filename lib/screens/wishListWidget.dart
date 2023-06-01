import 'package:cached_network_image/cached_network_image.dart';
import '../WidgetHelper/CustomIcons.dart';
import '../models/api/product/getProductsParent.dart';
import 'package:flutter/material.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../utils/prefrences.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({Key? key}) : super(key: key);


  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen>   {

  double boxSize=70;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: BackgroundColor,
        body: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                  )
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: BackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40,
                              width: 40,

                              child: Icon(Icons.arrow_back,
                                color: MainHighlighter,
                                size: 25,),
                            )
                        ),
                        Text(
                          LocalLanguageString().wishlist,
                          style: TextStyle(color: MainHighlighter,
                            fontSize: 20.0,
                            fontFamily: "Header",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(),

                      ],
                    ),
                  )
              ),
              Expanded(
                flex: 13,
                child: ListView(
                    children: getWishlistPref().length==0? [Container(
                      height: 200,
                      child: Center(
                        child: Text(
                          " No items marked yet ",
                          style: TextStyle(
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: NormalColor,
                          ),),
                      ),
                    )]:getWishlistPref().map((product) {
                      return favItems(product);
                    }).toList()
                )
              )

            ],
          ),
        )
    );

  }

  Widget favItems(GetProductsParent product) {

    if(product==null)
      return Container(child: Center(child: Text("Some things went wrong"),),);
    return Container(
      height: 110,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: transparent,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120,
              child: product.images.length>0? CachedNetworkImage(
                imageUrl: product.images[0].src,
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
              ) :Container(height: 80,width: 80,)
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "${product != null ? product.title : ""}".toUpperCase(),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                              color: MainHighlighter,
                              fontSize: 15,
                              fontFamily: "Normal",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        child: IconButton(
                          onPressed: () {
                            removeFromWishList(product.id);
                            setState(() {});
                          },
                          color: MainHighlighter,
                          icon: Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Rating :",
                        style: TextStyle(
                            color: NormalColor,
                            fontSize: 14,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w700
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(3),
                        child: getReviews(product.average_rating,product.rating_count),
                      ),

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Sales    ",
                        style: TextStyle(
                            color: NormalColor,
                            fontSize: 16,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(
                        product.total_sales.toString(),
                        style: TextStyle(
                          fontFamily: "Normal",
                          color: SecondaryHighlighter,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
