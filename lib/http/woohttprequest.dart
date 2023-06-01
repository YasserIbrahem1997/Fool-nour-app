import '../emuns/apptypes.dart';
import '../models/api/blogPosts/getBlogPosts.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/shippingZoneMethod/getShippingZoneMethods.dart';
import '../models/api/order/createOrderModel.dart';
import '../models/api/customer/cupdateCustomerUpdateModel.dart';
import '../models/api/coupon/getCoupons.dart';
import '../models/api/paymentMethod/getPaymentMethods.dart';
import '../models/api/shippingZone/getShippingZone.dart';

import '../models/api/customer/customerCreateModel.dart';
import '../models/api/customer/customerGetModel.dart';
import '../models/api/order/getOrders.dart';
import '../payments/config.dart';
import '../screens/splashWidget.dart';
import '../utils/commonMethod.dart';
import '../utils/consts.dart';
import '../utils/paginator.dart';
import '../utils/prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../models/api/customer/createCustomerResponceModel.dart';

class WooHttpRequest {
  //-----------------------------------WOOCOMMERCE SERVER-----------------------------------------------------//
  Future<String> getToken() async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    final response = await http.post(Uri.parse(JWT_AUTH + "token/"),
        headers: headers,
        body: {
          "username": WOOCOMM_JWT_USERNAME,
          "password": WOOCOMM_JWT_USERPASS
        });
    print(response.body.toString());
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body)["token"];
      return responseJson;
    } else {
      return "";
    }
  }

  //CUSTOMER
  Future<GetCustomer?> getCustomer(String email) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };
    // final response = await http.get(Uri.parse(WP_JSON_WC+"customers?email=$email"),headers: headers );
    print(WP_JSON_WC + "customers?email=$email$customAppenderAuth");
    final response = await http.get(
        Uri.parse(WP_JSON_WC + "customers?username=$email$customAppenderAuth"),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);

      List responseJson = json.decode(response.body);
      List<GetCustomer> customers =
          responseJson.map((data) => GetCustomer.fromJson(data)).toList();
      return customers.length > 0 ? customers.last : null;
    } else {
      return null;
    }
  }

  Future<CreateCustomerResponce?> addCustomer(
      CreateCustomer createCustomer) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };
    var body = json.encode(createCustomer.toJson());
    final response = await http.post(
        Uri.parse(WP_JSON_WC + "customers?$customAppenderAuth"),
        headers: headers,
        body: body);

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);
      CreateCustomerResponce createCustomerResponce =
          CreateCustomerResponce.fromJson(responseJson);
      return createCustomerResponce;
    } else if (response.statusCode == 400 &&
        json.decode(response.body)["code"] ==
            "registration-error-email-exists") {
      return null;
    } else {
      return null;
    }
  }

  Future<CreateCustomerResponce?> updateNewUser(
      int id, UpdateCustomer updateCustomer) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };
    var body = json.encode(updateCustomer.toJson());
    final response = await http.put(
        Uri.parse(WP_JSON_WC + "customers/${id}?$customAppenderAuth"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      CreateCustomerResponce createCustomerResponce =
          CreateCustomerResponce.fromJson(responseJson);
      return createCustomerResponce;
    } else {
      return null;
    }
  }

  // //TOTAL_PRODUCTS_COUNT
  // Future<List<GetTotalProductCount>> getTotalProductCount( ) async {
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": basicAuth
  //   };
  //   final response = await http.get(Uri.parse(WP_JSON_WC+"reports/products/totals"),headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     var responseJson = json.decode(response.body);
  //     return List<GetTotalProductCount>.from(responseJson.map((data) => GetTotalProductCount.fromJson(data)));
  //   } else {
  //     return [];
  //
  //   }
  // }
  //TOTAL_CATEGORY_COUNT
  // Future<int> getTotalCategoryCount( ) async {
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //   };
  //   final response = await http.get(Uri.parse(WOOCOMM_URL+"categories"),headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     int totalCategories = int.parse(response.body.trim());
  //     return totalCategories;
  //     // return 88;
  //   } else {
  //     return 0;
  //   }
  // }

  //SEARCH_PRODUCT
  Future<List<GetDashBoardProducts>> getSearchedProduct(
      String searchWord) async {
    int PER_PAGEITEMS =
        40; //not paggination required..customer can enter full search name manually for exact search
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    final response = await http.get(
        Uri.parse(WP_JSON_WC +
            "products?search=$searchWord&per_page=$PER_PAGEITEMS&page=1"),
        headers: headers);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetDashBoardProducts>.from(
          responseJson.map((data) => GetDashBoardProducts.fromJson(data)));
    } else {
      return [];
    }
  }

  //  CATEGORY
  // final int CATEGORY_PAGEITEMS=26;
  // Future<List<GetCategories>> getCategories( ) async {
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": basicAuth
  //   };
  //
  //   final response = await http.get(Uri.parse(WP_JSON_WC+"products/categories?per_page=$CATEGORY_PAGEITEMS&page=$categoryPage"),headers: headers);//per_page=100
  //
  //   if (response.statusCode == 200) {
  //     categoryPage++;
  //     List responseJson = json.decode(response.body);
  //     List catDataList=responseJson.map((data) {
  //       return GetCategories.fromJson(data);
  //     }).toList();
  //     return catDataList;
  //   } else {
  //     return [];
  //   }
  // }
  //
  // //PRODUCTS
  // final int PRODUCT_PAGEITEMS=36;
  // Future<List<GetProducts>> getProducts( ) async {
  //    // int PER_PAGEITEMS=30;
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": basicAuth
  //   };
  //   final response = await http.get(Uri.parse(WC_API+"products?filter[limit]=$PRODUCT_PAGEITEMS&page=$productPage"),headers: headers);//filter[limit] =-1
  //
  //   print(json.decode(response.body));
  //   if (response.statusCode == 200) {
  //     productPage++;
  //     var responseJson = json.decode(response.body)["products"];
  //     return List<GetProducts>.from(responseJson.map((data) => GetProducts.fromJson(data)));
  //   } else {
  //     return [];
  //
  //   }
  // }

  // //PRODUCTS_BY_CATEGORY
  // Future<List<GetProducts>> getProductByCategory(String slug) async {
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": basicAuth
  //   };
  //   final response = await http.get(Uri.parse(WC_API+"products?filter[limit]=100&filter[category]=$slug"),headers: headers);//filter[limit] =-1
  //
  //   if (response.statusCode == 200) {
  //     var responseJson = json.decode(response.body)["products"];
  //     return List<GetProducts>.from(responseJson.map((data) => GetProducts.fromJson(data)));
  //   } else {
  //     return [];
  //   }
  // }

  //ORDERS

  /* todo هنا انا ممكن اجيب جميع الاوردارات المطلبوبة الي موجوده في الداش بورد   */
  Future<List<GetOrderResponce>> getOrders() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };

    final response = await http.get(
        Uri.parse(WP_JSON_WC + "orders?$customAppenderAuth"),
        headers: headers);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<GetOrderResponce> listResponce =
          responseJson.map((data) => GetOrderResponce.fromJson(data)).toList();
      List<GetOrderResponce> _tempListResponce = [];
      listResponce.forEach((data) {
        if (data.billing.email == getCustomerDetailsPref().email) {
          print('order: ');
          print(data.id);
          _tempListResponce.add(data);
        }
      });
      return _tempListResponce;
    } else {
      return [];
    }
  }

  Future putNewOrder(
      BuildContext context,
      String payment_method,
      String payment_method_title,
      Map<String, String> shipping_lines,
      String customer_note) async {
    if (shipping_lines["method_id"] == "0") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Required'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Shipment method missing',
          onPressed: () {},
        ),
      ));
      return false;
    }
    List<Line_items> lineItems = getCartProductsPref();
    CreateCustomer createCustomer = getCustomerDetailsPref();
    CreateOrder createOrder = new CreateOrder(
        payment_method,
        payment_method_title,
        false,
        createCustomer.billing,
        createCustomer.shipping,
        lineItems,
        [shipping_lines],
        customer_note);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": basicAuth
    };

    var body = json.encode(createOrder.toJson());
    final response = await http.post(
        Uri.parse(WP_JSON_WC + "orders?$customAppenderAuth"),
        headers: headers,
        body: body);

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);
      if (responseJson["order_key"] != "") {
        delAllCartProductsPref();
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  //SHIPPING ZONE
  Future<List<GetShippingZone>> getShippingZones() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String bearerAuth = 'Bearer ${await getRecentToken()}';

    // headers.addAll({"Authorization": APPTYPE==AppType.Wooflux?
    //     basicAuth: (APPTYPE==AppType.Dokan || APPTYPE==AppType.WCFM)?
    //         bearerAuth:""
    //   });
    headers.addAll({
      "Authorization": (APPTYPE == AppType.Dokan || APPTYPE == AppType.WCFM)
          ? bearerAuth
          : ""
    });

    final response = await http.get(
        Uri.parse(WP_JSON_WC + "shipping/zones?$customAppenderAuth"),
        headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<GetShippingZone> shippingZoneId = List<GetShippingZone>.from(
          responseJson.map((data) => GetShippingZone.fromJson(data)).toList());
      return shippingZoneId;
    } else {
      return [];
    }
  }

  //SHIPPING ZONE METHOD
  Future<List<GetShippingZoneMethods>> getShippingZonesMethod(int id) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String bearerAuth = 'Bearer ${await getRecentToken()}';

    // headers.addAll({"Authorization": APPTYPE==AppType.Wooflux?
    // basicAuth: (APPTYPE==AppType.Dokan || APPTYPE==AppType.WCFM)?
    // bearerAuth:""
    // });

    headers.addAll({
      "Authorization": (APPTYPE == AppType.Dokan || APPTYPE == AppType.WCFM)
          ? bearerAuth
          : ""
    });

    final response = await http.get(
        Uri.parse(
            WP_JSON_WC + "shipping/zones/$id/methods?$customAppenderAuth"),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);

      List responseJson = json.decode(response.body);
      List<GetShippingZoneMethods> shippingZoneId =
          List<GetShippingZoneMethods>.from(responseJson
              .map((data) => GetShippingZoneMethods.fromJson(data))
              .toList());
      return shippingZoneId;
    } else {
      return [];
    }
  }

  // //SETTING
  // Future<String> getSettings( ) async {
  //   String code="GBP";
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": basicAuth
  //   };
  //   final response = await http.get(Uri.parse(WP_JSON_WC+"settings/general"),headers: headers );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //
  //     List responseJson = json.decode(response.body);
  //     responseJson.forEach((element) {
  //       if(element["id"]=="woocommerce_currency")
  //         code= element["value"];
  //     });
  //     return code;
  //   } else {
  //     return code;
  //   }
  // }
  //COUPON

  Future<List<GetAllCoupon>> getCoupon() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String bearerAuth = 'Bearer ${await getRecentToken()}';

    // headers.addAll({"Authorization": APPTYPE==AppType.Wooflux?
    // basicAuth: (APPTYPE==AppType.Dokan || APPTYPE==AppType.WCFM)?
    // bearerAuth:""
    // });

    headers.addAll({
      "Authorization": (APPTYPE == AppType.Dokan || APPTYPE == AppType.WCFM)
          ? bearerAuth
          : ""
    });

    final response = await http.get(
        Uri.parse(WP_JSON_WC + "coupons?$customAppenderAuth"),
        headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<GetAllCoupon> getCoupon = List<GetAllCoupon>.from(
          responseJson.map((data) => GetAllCoupon.fromJson(data)).toList());
      return getCoupon;
    } else {
      return [];
    }
  }

  //PAYMENTGATEWAY
  Future<List<GetPaymentGateway>?> getPaymentGatways() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'));
    String customAppenderAuth =
        "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
    String bearerAuth = 'Bearer ${await getRecentToken()}';

    // headers.addAll({"Authorization": APPTYPE==AppType.Wooflux?
    // basicAuth: (APPTYPE==AppType.Dokan || APPTYPE==AppType.WCFM)?
    // bearerAuth:""
    // });

    headers.addAll({
      "Authorization": (APPTYPE == AppType.Dokan || APPTYPE == AppType.WCFM)
          ? bearerAuth
          : ""
    });

    final response = await http.get(
        Uri.parse(WP_JSON_WC + "payment_gateways?$customAppenderAuth"),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);

      List responseJson = json.decode(response.body);
      List<GetPaymentGateway> paymentGateway = List<GetPaymentGateway>.from(
          responseJson
              .map((data) => GetPaymentGateway.fromJson(data))
              .toList());
      return paymentGateway;
    } else {
      return null;
    }
  }

  //BLOG_POSTS
  Future<List<GetBlogPosts>?> getBlogPosts() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(
        Uri.parse(WP_JSON_WP_V2 + "posts?per_page=8&page=$blogpost_page"),
        headers: headers);
    if (response.statusCode == 200) {
      blogpost_page++;
      print(response.body);
      List responseJson = json.decode(response.body);
      List<GetBlogPosts> listPosts = List<GetBlogPosts>.from(
          responseJson.map((data) => GetBlogPosts.fromJson(data)).toList());
      return listPosts;
    } else {
      return null;
    }
  }

//-----------------------------------PAYMENTS-----------------------------------------------------//

  //paypal
  Future<String?> getAuthPaypal() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$PAYPAL_AUTH_USER:$PAYPAL_AUTH_PASS'));
    print(basicAuth);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": basicAuth
    };

    Map bodyMap = {"grant_type": "client_credentials"};
    final response = await http.post(Uri.parse(PAYPAL_SERVER + "oauth2/token"),
        headers: headers, body: (bodyMap));
    if (response.statusCode == 200) {
      print(response.body);

      var responseJson = json.decode(response.body);

      return responseJson['access_token'];
    } else {
      return null;
    }
  }

  Future<Map?> paymentPaypal(String token, double amount, double shippingAmount,
      String currencyCode) async {
    String bearerAuth = 'Bearer $token';
    print(bearerAuth);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      "Accept": "application/json",
      "Authorization": bearerAuth
    };

    Map<dynamic, dynamic> bodyMap =
        getConfigPaypal(amount, shippingAmount, currencyCode);
    final response = await http.post(
        Uri.parse(PAYPAL_SERVER + "payments/payment"),
        headers: headers,
        body: json.encode(bodyMap).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      var responseJson = json.decode(response.body);
      String? approval_url = null;
      String? execute = null;
      if (responseJson != null && responseJson["links"] != null) {
        List links = responseJson["links"];
        links.forEach((data) {
          if (data["rel"] == "approval_url")
            approval_url = data["href"];
          else if (data["rel"] == "execute") execute = data["href"];
        });
      }
      return {"approval_url": approval_url, "execute": execute};
    } else {
      return null;
    }
  }

  Future<bool> paymentPaypalExecute(
      String token, String payerid, String executeUrl) async {
    String bearerAuth = 'Bearer $token';
    print(bearerAuth);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      "Accept": "application/json",
      "Authorization": bearerAuth
    };

    Map bodyMap = {"payer_id": "$payerid"};

    final response = await http.post(Uri.parse(executeUrl),
        headers: headers, body: json.encode(bodyMap).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      var responseJson = json.decode(response.body);
      return true;
    } else {
      return false;
    }
  }

  //tap
  Future<String?> getTapUrl(
      double amount, double shippingAmount, String currencyCode) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-type': 'application/json',
      "Authorization": "Bearer $TAP_KEY"
    };

    Map<dynamic, dynamic> bodyMap =
        getConfigTap(amount, shippingAmount, currencyCode);
    final response = await http.post(Uri.parse(TAP_SERVER + "charges"),
        headers: headers, body: json.encode(bodyMap).toString());
    if (response.statusCode == 200) {
      print(response.body);

      var responseJson = json.decode(response.body);
      if (responseJson != null &&
          responseJson['transaction'] != null &&
          responseJson['transaction'] != "")
        return responseJson["transaction"]["url"];
      else
        return null;
    } else {
      return null;
    }
  }
}
