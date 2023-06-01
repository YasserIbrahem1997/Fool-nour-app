
import 'customerBillingModel.dart';
import 'customerShippingModel.dart';

class UpdateCustomer{
  String first_name;
  String last_name;
  Billing billing;
  Shipping shipping;

  UpdateCustomer( this.first_name, this.last_name, this.billing, this.shipping);

  UpdateCustomer.fromJson(Map<String, dynamic> jsonData):
        first_name = jsonData['first_name'] ?? "",
        last_name = jsonData['last_name'] ?? "",
        billing = Billing.fromJson(jsonData['billing'] ?? Billing("", "", "", "", "", "", "", "", "", "", "").toJson()),
        shipping = Shipping.fromJson(jsonData['shipping'] ??  Shipping("", "", "", "", "", "", "", "", "").toJson())
  {}

  Map<String, dynamic> toJson() =>
      {
        'first_name': first_name,
        'last_name': last_name,
        'billing': billing.toJson(),
        'shipping': shipping.toJson(),
      };
}
