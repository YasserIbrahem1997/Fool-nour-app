import '../models/api/dashboard/getDashboardProducts.dart';
import '../utils/consts.dart';
import '../wcfm/models/api/vendor/getAllWcfmVendorsResponceModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class WooHttpWcfmRequest {

//VENDORS
  Future<List<GetAllWcfmVendors>> getWcfmVendors(String token) async {

    String basicAuth = 'Bearer $token';
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    final response = await http.get(Uri.parse(WCFMMP_API+"store-vendors"),headers: headers);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body) ;
      return List<GetAllWcfmVendors>.from(responseJson.map((data) => GetAllWcfmVendors.fromJson(data)));
    } else {
      return[];
    }
  }
  //VENDOR PRODUCTS
  Future<List<GetDashBoardProducts>> getWcfmVendorProducts(String token,int venId) async {


    String basicAuth = 'Bearer $token';
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    final response = await http.get(Uri.parse(WCFMMP_API+"store-vendors/$venId/products"),headers: headers);

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