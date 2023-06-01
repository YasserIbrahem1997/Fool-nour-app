
import 'customerBillingModel.dart';
import 'customerShippingModel.dart';

class GetCustomer{
  late int id;
  String email;
  String first_name;
  String last_name;
  String username;
  Billing billing;
  Shipping shipping;

  GetCustomer(this.email, this.first_name, this.last_name, this.username, this.billing, this.shipping);

  GetCustomer.fromJson(Map<String, dynamic> jsonData):
        id = jsonData['id'] ?? 0,
        email = jsonData['email'] ?? "nofound@gemail.com",
        first_name = jsonData['first_name'] ?? "",
        last_name = jsonData['last_name'] ?? "",
        username = jsonData['username'] ?? "",
        billing = Billing.fromJson(jsonData['billing'] ?? Billing("", "", "", "", "", "", "", "", "", "", "").toJson()),
        shipping = Shipping.fromJson(jsonData['shipping'] ??  Shipping("", "", "", "", "", "", "", "", "").toJson())
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'username': username,
        'billing': billing.toJson(),
        'shipping': shipping.toJson(),
      };
}