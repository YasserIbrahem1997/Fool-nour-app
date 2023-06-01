// import 'dart:async';
//
// //import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecom/bloc/bloc_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_shimmer/flutter_shimmer.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:ecom/bloc/bloc_searchProduct.dart';
// import 'package:ecom/models/api/dashboard/getDashboardCategory.dart';
// import 'package:ecom/models/api/product/getProducts.dart';
// import 'package:ecom/screens/splashWidget.dart';
// import 'package:ecom/utils/appTheme.dart';
// import 'package:ecom/utils/languages_local.dart';
// import 'package:progress_indicators/progress_indicators.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class TagSlidingCard {
//
//   Widget getTagsHeader(){
//     List<GetDashboardCategories> totalCategories= getTotalCategories();
//     return Column(
//       children: <Widget>[
//         Container(
//           padding:  EdgeInsets.all( 8.0,),
//           margin:  EdgeInsets.only(top: 13.0,),
//           alignment: Alignment.centerLeft,
//           child: Text(
//             LocalLanguageString().tags,
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               fontWeight: FontWeight.w900,
//               fontSize: 18,
//               letterSpacing: 0.27,
//               fontFamily: "Normal",
//               color: NormalColor,
//             ),
//           ),
//         ), StreamBuilder(
//           stream: productBloc.getProductStreamController.stream,
//           initialData: products,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return snapshot.data!=null? getListTags(context):
//             ListTileShimmer(
//               isPurplishMode: false,
//               hasBottomBox: false,
//               isDarkMode: false,
//             );
//           },
//         )
//       ],
//     );
//   }
//   Widget getListTags(BuildContext context) {
//     PageController pageController  = PageController(viewportFraction: 1);
//     Map<String, List<GetProducts>> tagWithProduct = Map();
//     products.forEach((_product) {
//       _product.tags.forEach((tag) {
//         if (tagWithProduct.containsKey(tag)) {
//           Set<GetProducts> _override = tagWithProduct[tag].toSet();
//           _override.add(_product);
//           tagWithProduct[tag] = _override.toList();
//         } else
//           tagWithProduct[tag] = [_product];
//       });
//     });
//
//     if(products.length==0)
//       {
//         return Container(
//           height: 200,
//           child: VideoShimmer(
//             isPurplishMode: false,
//             hasBottomBox: false,
//             isDarkMode: false,
//           ),
//         );
//       }
//
//
//     return tagWithProduct.keys.length==0?Container():Container(
//       height: 200,
//       child: Flex(
//         direction: Axis.vertical,
//         children: <Widget>[
//           Expanded(
//             flex: 10,
//             child: PageView(
//                 controller: pageController,
//                 children: tagWithProduct.keys.map((key) {
//                   return Container(
//                     color: NormalColor.withAlpha(10),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, '/subproduct', arguments: {'_subProducts': tagWithProduct[key], '_title': key});
//                       },
//                       child: cardItem(context, key, tagWithProduct[key]),
//                     ),
//                   );
//                 }).toList()
//
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: SizedBox(
//               child: SmoothPageIndicator(
//                 controller: pageController, // PageController
//                 count: tagWithProduct.keys.length,
//                 effect: ExpandingDotsEffect(
//                   radius: 5.0,
//                   dotHeight: 10.0,
//                   dotWidth: 8.0,
//                   strokeWidth: 1.5,
//                   dotColor: NormalColor.withAlpha(40),
//                   activeDotColor: NormalColor.withAlpha(80),
//                 ), // your preferred effect
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//   Widget cardItem(BuildContext context, String key, List<GetProducts> tagWithProduct) {
//
//     ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
//     Future.delayed( Duration(milliseconds : 1000), (){
//       if(_scrollController.hasClients)
//       _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(seconds: 5),
//           curve: Curves.easeOut
//       );
//     });
//
//
//     return Stack(
//       children: <Widget>[
//         Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width * 0.47,
//               margin: EdgeInsets.all(10),
//               child: StaggeredGridView.countBuilder(
//                 shrinkWrap: true,
//                 controller: _scrollController,
//                 crossAxisCount: 4,
//                 scrollDirection: Axis.vertical,
//                 itemCount: tagWithProduct.length,
//                 itemBuilder: (BuildContext context, int index) =>
//                     Container(
//                         child: tagWithProduct[index].images != null && tagWithProduct[index].images.length > 0 ?
//                         // Image.network(
//                         //   tagWithProduct[index].images[0].src,
//                         //   fit: BoxFit.cover,
//                         // )
//                        CachedNetworkImage(
//                          imageUrl: tagWithProduct[index].images[0].src,
//                          imageBuilder: (context, imageProvider) =>
//                              Container(
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.all(
//                                      Radius.circular(10.0) //                 <--- border radius here
//                                  ),
//                                  image: DecorationImage(
//                                    image: imageProvider,
//                                    fit: BoxFit.cover,
//                                  ),
//                                ),
//                              ),
//                          placeholder: (context, url) =>
//                              Center(child: JumpingDotsProgressIndicator(
//                                fontSize: 20.0,)),
//                          errorWidget: (context, url, error) =>
//                              Center(child: Icon(Icons.filter_b_and_w),),
//                        )
//                             : Container(color: Colors.transparent)
//                     ),
//                 staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
//                 mainAxisSpacing: 2.0,
//                 crossAxisSpacing: 2.0,
//               )
//           ),
//         ),
//         Container(
//           color: Colors.transparent,
//           alignment: Alignment.centerLeft,
//           margin: EdgeInsets.all(10),
//           width: MediaQuery
//               .of(context)
//               .size
//               .width ,
//           child: Text(key,
//             style: TextStyle(
//             fontFamily: "Normal",
//             fontWeight: FontWeight.w600,
//             fontSize: 19,
//             color: NormalColor,
//           ),
//           ),
//         )
//
//       ],
//     );
//   }
//
// }