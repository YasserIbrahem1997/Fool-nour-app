
import '../bloc/bloc_dashboard.dart';
import '../http/customhttprequest.dart';
import '../http/woohttprequest.dart';
import '../models/api/coupon/getCoupons.dart';
import '../models/api/dashboard/getDashboard.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../screens/splashWidget.dart';
import '../dokan/screens/dokanVendorsWidget.dart';
import '../dokan/woohttprequest.dart';
import 'package:collection/collection.dart';
// GetProducts getProductFromId(int productId){
//   GetProducts thisProduct=null;
//   if(products!=null)
//   products.forEach((_Product){
//     if(_Product.id==productId)
//       thisProduct=_Product;
//   });
//
//   return thisProduct;
// }

bool isValidTokenForProduct(GetAllCoupon _coupon,GetDashBoardProducts getproduct){
  List<int> valid=_coupon.product_ids;

  valid.removeWhere((couponProductId) =>
      _coupon.excluded_product_ids.contains(couponProductId)
  );
  int data=valid.firstWhere((element) => element==getproduct.id,orElse:() => 0);
  return data!=0 ;

}

bool isValidTokenForP_Category(GetAllCoupon _coupon,List<GetDashboardCategories> productCategories){
  List<int> validCategories=_coupon.product_categories;

  validCategories.removeWhere((couponCategoryId) =>
    _coupon.excluded_product_categories.contains(couponCategoryId)
  );
  GetDashboardCategories? data=productCategories.firstWhereOrNull((dashBoardCat) => dashBoardCat.id==
      validCategories.firstWhere((element) => element==dashBoardCat.id,orElse:() => 0)
      );
  return data!=null ;
}

// bool isValidTokenForAnyCartProduct(_coupon){
//   bool couponAppicableOnProduct=_coupon.product_ids.length==0;
//   _coupon.product_ids.forEach((CouponProductId) {
//     int _excludeproductId =_coupon.excluded_product_ids.firstWhere((_exProductId) => _exProductId==CouponProductId,orElse:() =>  0);
//     Line_items cartItem =getCartProductsPref().firstWhere((_product) => _product.product_id==CouponProductId,orElse:() =>  null);
//     if(cartItem!=null && _excludeproductId==0){
//       couponAppicableOnProduct= true;
//     }
//   });
//   return couponAppicableOnProduct;
// }
//
// bool isValidTokenForAnyCartCategory(_coupon){
//   bool couponAppicableOnCategories=_coupon.product_categories.length==0;
//   _coupon.product_categories.forEach((CouponCategoryId) {
//     int _excludeCatId =_coupon.excluded_product_categories.firstWhere((_exCatId) => _exCatId==CouponCategoryId,orElse:() =>  0);
//
//     if(  _excludeCatId==0){
//       GetProducts product=products.firstWhere((_product) {
//         Line_items item=getCartProductsPref().firstWhere((_item) => _item.product_id==_product.id,orElse:() => null);
//         GetCategories cat=categories.firstWhere((category) => category.id==CouponCategoryId && _product.categories.contains(category.name),orElse:() => null);
//         return  cat!=null && item!=null;
//       },orElse:() =>  null);
//
//       if(product!=null)
//         couponAppicableOnCategories=true;
//     }
//   });
//   return couponAppicableOnCategories;
// }

int getPercentageOnsale(double sale_price,double price) {
    double percent= ( sale_price/price ) ;
    percent=percent*100;
    return (100-percent).toInt();
}
String jwtToken="";
DateTime? lastTokenCallTime;
Future<String> getRecentToken()async{
  if(jwtToken=="" || lastTokenCallTime==null || (lastTokenCallTime!=null && DateTime.now().difference(lastTokenCallTime!).inMinutes>15)) {
    jwtToken = await WooHttpRequest().getToken();
    lastTokenCallTime = DateTime.now();
  }
  return jwtToken;

}

//
// refreshProducts(List<GetProducts> _products){
//   if(products==null)
//     products=[];
//
//   _products.forEach((item) {
//     var alreadyExistItem= products.firstWhere((element) => element.id==item.id,orElse:() =>null);
//     if (alreadyExistItem==null)
//       products.add(item);
//   });
// }
// refreshCategories(List<GetCategories> _categories){
//   if(categories==null)
//     categories=[];
//
//   _categories.forEach((item) {
//     var alreadyExistItem= categories.firstWhere((element) => element.id==item.id,orElse:() =>null);
//     if (alreadyExistItem==null)
//       categories.add(item);
//   });
//  }