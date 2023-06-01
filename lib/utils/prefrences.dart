import 'dart:convert';
import '../bloc/bloc_searchProduct.dart';
import '../main.dart';
import '../models/api/customer/customerBillingModel.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/order/createOrderModel.dart';
import '../models/api/customer/customerCreateModel.dart';
import '../models/api/customer/customerShippingModel.dart';
import '../utils/consts.dart';
import '../extentionHelper.dart';
import '../http/woohttprequest.dart';

//------------------------------------Customer -------------------------------//
setCustomerDetailsPref(CreateCustomer? createCustomer) {
  if (createCustomer == null)
    prefs!.remove(CUSTOMERDETAILS);
  else
    prefs!.setString(CUSTOMERDETAILS, json.encode(createCustomer.toJson()));
}

CreateCustomer getCustomerDetailsPref() {
  String createCustomerPref = prefs!.getString(CUSTOMERDETAILS) ??
      json.encode(CreateCustomer(
              "",
              "",
              "",
              "",
              Billing("", "", "", "", "", "", "", "", "", "", ""),
              Shipping("", "", "", "", "", "", "", "", ""))
          .toJson());

  var responseJson = json.decode(createCustomerPref);
  CreateCustomer createCustomer = CreateCustomer.fromJson(responseJson);

  return createCustomer;
}

//------------------------------------Cart -------------------------------//
Future<bool> addORupdateCartProductsPref(Line_items cartProduct) async {
  String currCartProductsPref = prefs!.getString(CARTPRODUCTS) ?? "[]";

  List responseJson = json.decode(currCartProductsPref);
  List<Line_items> cartList = List<Line_items>.from(
      responseJson.map((data) => Line_items.fromJson(data)).toList());
  bool found = false;
  for (int pos = 0; pos < cartList.length; pos++)
    if (cartList[pos].product_id == cartProduct.product_id &&
        cartList[pos].variation_id == cartProduct.variation_id) {
      cartList.update(pos, cartProduct);
      found = true;
      break;
    }
  if (!found) cartList.add(cartProduct);

  var data =
      cartList.map((data) => json.encode(data.toJson())).toList().toString();
  await prefs!.setString(CARTPRODUCTS, data);
  return true;
}

List<Line_items> getCartProductsPref() {
  String currCartProductsPref = prefs!.getString(CARTPRODUCTS) ?? "[]";
  List responseJson = json.decode(currCartProductsPref);
  List<Line_items> cartList = List<Line_items>.from(
      responseJson.map((data) => Line_items.fromJson(data)).toList());
  return cartList;
}

Future<bool> delCartProductsPref(int product_id, int variation_id) async {
  String currCartProductsPref = prefs!.getString(CARTPRODUCTS) ?? "[]";

  List responseJson = json.decode(currCartProductsPref);
  List<Line_items> cartList = List<Line_items>.from(
      responseJson.map((data) => Line_items.fromJson(data)).toList());

  for (int x = 0; x < cartList.length; x++) {
    if (cartList[x].product_id == product_id &&
        cartList[x].variation_id == variation_id) {
      cartList.removeAt(x);
    }
  }

  var data =
      cartList.map((data) => json.encode(data.toJson())).toList().toString();
  await prefs!.setString(CARTPRODUCTS, data);
  return true;
}

Future<bool> delAllCartProductsPref() async {
  await prefs!.setString(CARTPRODUCTS, "[]");
  return true;
}

//------------------------------------Recents -------------------------------//
addRecentViewedPref(GetDashBoardProducts product) async {
  String recentListProductsPref = prefs!.getString(RECENTSVIEWED) ?? "[]";
  List responseJson = json.decode(recentListProductsPref);
  List<GetDashBoardProducts> recentListProducts =
      List<GetDashBoardProducts>.from(responseJson
          .map((data) => GetDashBoardProducts.fromJson(data))
          .toList());
  for (int pos = 0; pos < recentListProducts.length; pos++)
    if (recentListProducts[pos].id == product.id) {
      recentListProducts.removeAt(pos);
    }
  recentListProducts.add(product);
  var data = recentListProducts
      .map((data) => json.encode(data.toJson()))
      .toList()
      .toString();
  await prefs!.setString(RECENTSVIEWED, data);
}

List<GetDashBoardProducts> getRecentlistPref() {
  String recentListProductsPref = prefs!.getString(RECENTSVIEWED) ?? "[]";
  List responseJson = json.decode(recentListProductsPref);
  List<GetDashBoardProducts> recentList = List<GetDashBoardProducts>.from(
          responseJson
              .map((data) => GetDashBoardProducts.fromJson(data))
              .toList())
      .reversed
      .toList();
  return recentList.length > 10 ? recentList.sublist(0, 10) : recentList;
}

//------------------------------------WishList -------------------------------//
addWhishlistPref(GetDashBoardProducts product) async {
  String wishListProductsPref = prefs!.getString(WISHLIST) ?? "[]";
  List responseJson = json.decode(wishListProductsPref);
  List<GetDashBoardProducts> wishListProducts = List<GetDashBoardProducts>.from(
      responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());
  bool found = false;
  for (int pos = 0; pos < wishListProducts.length; pos++)
    if (wishListProducts[pos].id == product.id) {
      wishListProducts.update(pos, product);
      found = true;
      break;
    }
  if (!found) wishListProducts.add(product);

  var data = wishListProducts
      .map((data) => json.encode(data.toJson()))
      .toList()
      .toString();
  await prefs!.setString(WISHLIST, data);
}

Future<bool> removeFromWishList(int productId) async {
  String currWishListProductsPref = prefs!.getString(WISHLIST) ?? "[]";

  List responseJson = json.decode(currWishListProductsPref);
  List<GetDashBoardProducts> wishListList = List<GetDashBoardProducts>.from(
      responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());

  wishListList.removeWhere((value) => value.id == productId);

  var data = wishListList
      .map((data) => json.encode(data.toJson()))
      .toList()
      .toString();
  await prefs!.setString(WISHLIST, data);
  return true;
}

List<GetDashBoardProducts> getWishlistPref() {
  String wishListProductsPref = prefs!.getString(WISHLIST) ?? "[]";
  List responseJson = json.decode(wishListProductsPref);
  List<GetDashBoardProducts> wishList = List<GetDashBoardProducts>.from(
      responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());
  return wishList;
}

//------------------------------------Language -------------------------------//

String getLanguageCode() {
  String languageCode = prefs!.getString(LANGUAGE) ?? "en";
  return languageCode;
}

Future<bool> setLanguageCode(String languageCode) async {
  await prefs!.setString(LANGUAGE, languageCode);
  return true;
}

//------------------------------------Theme -------------------------------//
bool isDarkTheme() {
  bool darkTheme = prefs! != null ? prefs!.getBool(DARKTHEME) ?? false : false;
  return darkTheme;
}

Future<bool> setDarkTheme(bool darkTheme) async {
  await prefs!.setBool(DARKTHEME, darkTheme);
  return true;
}
