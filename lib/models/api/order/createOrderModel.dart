
import '/models/api/customer/customerBillingModel.dart';
import '/models/api/customer/customerShippingModel.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import 'package:flutter/cupertino.dart';

class CreateOrder{
  String payment_method;
  String payment_method_title;
  String customer_note;
  bool set_paid;
  Billing billing;
  Shipping shipping;
  List<Line_items> line_items;
  List<Map<String,String>> shipping_lines;

  CreateOrder(this.payment_method, this.payment_method_title, this.set_paid, this.billing, this.shipping, this.line_items, this.shipping_lines, this.customer_note);

  Map<String, dynamic> toJson() =>
      {
        'payment_method': payment_method,
        'payment_method_title': payment_method_title,
        'set_paid': set_paid,
        'billing': billing,
        'shipping': shipping,
         'line_items': line_items.map((element) {
          return element.toJson();
        }).toList(),
        'shipping_lines': shipping_lines,
        'customer_note': customer_note
      };
}

class Line_items{
  int product_id;
  int variation_id=-1;
  int quantity;
  String comment;
  GetDashBoardProducts productDetail;// only for cart screen .
  Line_items(this.product_id, this.variation_id, this.quantity, this.productDetail,this.comment){}

  Line_items.fromJson(Map<String, dynamic> json):
        product_id = json['product_id'],
        variation_id = json.containsKey("variation_id")?json['variation_id']:-1,
        quantity = json['quantity'],
        productDetail = GetDashBoardProducts.fromJson(json['productDetail']),
        comment = json['meta_data'][0]["value"]
  {}

  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> map={
        'product_id': product_id,
        'variation_id': variation_id,
        'quantity': quantity,
        'productDetail': productDetail.toJson(),
        'meta_data': [
          {
            "key": "comment",
            "value": comment
          }
        ],
      };
    map.removeWhere((key, value) => (key=="variation_id"&& value == -1));
    return map;
  }
}
