
import '/models/api/customer/customerBillingModel.dart';
import '/models/api/customer/customerShippingModel.dart';

class GetOrderResponce{
  int id;
  String order_key;
  String status;
  String total;
  String total_tax;
  int customer_id;
  String payment_method_title;
  String transaction_id;
  Billing billing;
  Shipping shipping;
  List<Get_Line_items> line_items;

  GetOrderResponce(this.id, this.order_key, this.status, this.total, this.total_tax, this.customer_id, this.payment_method_title, this.transaction_id, this.billing, this.shipping, this.line_items);

  GetOrderResponce.fromJson(Map<String, dynamic> json):
        id = json['id'],
        order_key = json['order_key'],
        status = json['status'],
        total = json['total'],
        customer_id = json['customer_id'],
        total_tax = json['total_tax'],
        payment_method_title = json['payment_method_title'],
        transaction_id = json['transaction_id'],
        billing = Billing.fromJson(json['billing']),
        shipping = Shipping.fromJson(json['shipping']),
        line_items =  List<Get_Line_items>.from(json['line_items'].map((data) => Get_Line_items.fromJson(data)).toList())
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'order_key': order_key,
        'status': status,
        'total': total,
        'customer_id': customer_id,
        'total_tax': total_tax,
        'payment_method_title': payment_method_title,
        'transaction_id': transaction_id,
        'billing': billing,
        'shipping': shipping,
        'line_items': line_items,
      };
}

class Get_Line_items{
  late int id;
  late int product_id;
  late int variation_id;
  late int quantity;
  late String total;
  Get_Line_items(this.product_id, this.variation_id, this.quantity );

  Get_Line_items.fromJson(Map<String, dynamic> json):
        product_id = json['product_id'],
        variation_id = json['variation_id'],
        quantity = json['quantity']{}

  Map<String, dynamic> toJson() =>
      {
        'product_id': product_id,
        'variation_id': variation_id,
        'quantity': quantity,
      };
}
