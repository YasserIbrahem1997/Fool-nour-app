import 'dart:developer';

import '../models/api/dashboard/getDashboard.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../screens/splashWidget.dart';
import '../utils/consts.dart';
import '../utils/paginator.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CustomHttpRequest {
//-----------------------------------WOOCOMMERCE CUSTOM API-----------------------------------------------------//

  //CUSTOM : DASHBOARD
  Future<GetDashboard?> getDashboard(int page) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(
        Uri.parse(WOOCOMM_URL + "dashboard-api/?paged=$page"),
        headers: headers); //filter[limit] =-1

    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body).toString(), wrapWidth: 1024);
      dashboard_page++;
      var responseJson = json.decode(response.body);
      print('responseJson');
      print(responseJson['sales_products']);
      return GetDashboard.fromJson(responseJson);
    } else {
      return null;
    }
  }

  //CUSTOM : PRODUCT FROM ID
  Future<List<GetDashBoardProducts>> getProductsFromId(List<int> ids) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String idsList = "";
    ids.forEach((element) {
      idsList = idsList + "$element,";
    });
    if (idsList.length > 0) idsList = idsList.substring(0, idsList.length - 1);
    print(WOOCOMM_URL + "product-by-id/?id=$idsList");
    final response = await http.get(
        Uri.parse(WOOCOMM_URL + "product-by-id/?id=$idsList"),
        headers: headers);

    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetDashBoardProducts>.from(
          responseJson.map((data) => GetDashBoardProducts.fromJson(data)));
    } else {
      return [];
    }
  }

  //CUSTOM : PRODUCTS_BY_CATEGORY
  Future<List<GetDashBoardProducts>> getProductFromCategoryId(int id) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(
        Uri.parse(WOOCOMM_URL + "category-products-api/?id=$id"),
        headers: headers); //filter[limit] =-1

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetDashBoardProducts>.from(
          responseJson.map((data) => GetDashBoardProducts.fromJson(data)));
    } else {
      return [];
    }
  }

  //CUSTOM : TOP_SELLING_PRODUCT
  Future<List<GetDashBoardProducts>> getTopSellingProducts() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(
        Uri.parse(WOOCOMM_URL + "top-selling-products/"),
        headers: headers); //filter[limit] =-1

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetDashBoardProducts>.from(
          responseJson.map((data) => GetDashBoardProducts.fromJson(data)));
    } else {
      return [];
    }
  }

  //CUSTOM : SEARCH_PRODUCT
  Future<List<GetDashBoardProducts>> getSearchProducts(
      String searchKeyWord) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(
        Uri.parse(WOOCOMM_URL + "product-search-api/?search=$searchKeyWord"),
        headers: headers); //filter[limit] =-1

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetDashBoardProducts>.from(
          responseJson.map((data) => GetDashBoardProducts.fromJson(data)));
    } else {
      return [];
    }
  }
}
