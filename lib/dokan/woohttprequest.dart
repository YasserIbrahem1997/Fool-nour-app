import '../models/api/dashboard/getDashboardProducts.dart';
import '../utils/consts.dart';
import '../dokan/models/api/vendor/getAllDokanVendorsResponceModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class WooHttpDokanRequest {

//VENDORS
  Future<List<GetAllDokanVendors>> getDokanVendors(String token) async {

    String customAppenderAuth= "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String basicAuth = 'Bearer $token';
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };

    final response = await http.get(Uri.parse(DOKAN_API+"stores?$customAppenderAuth&per_page=100&page=1"),headers: headers);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body) ;
      return List<GetAllDokanVendors>.from(responseJson.map((data) => GetAllDokanVendors.fromJson(data)));
    } else {
      return[];
    }
  }
  //VENDOR PRODUCTS مالوش علاقة بالمنتجات الي ظهره او الداخلي
  Future<List<GetDashBoardProducts>> getDokanVendorProducts(String token,int venId) async {


    String customAppenderAuth= "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String basicAuth = 'Bearer $token';
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };

    final response = await http.get(Uri.parse(DOKAN_API+"stores/$venId/products?$customAppenderAuth&per_page=100&page=1"),headers: headers);

    print(response.body.toString());
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body) ;
      List<GetDashBoardProducts> data = List<GetDashBoardProducts>.from(responseJson.map((data) {
        GetDashBoardProducts _getDashBoardProducts=GetDashBoardProducts.fromJson(data);
        _getDashBoardProducts.vendorId=venId.toString();
        return _getDashBoardProducts;
      }));
      return data;
    } else {
      return[];
    }
  }
}