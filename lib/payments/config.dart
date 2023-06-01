import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import '../utils/consts.dart';
import '../utils/prefrences.dart';

List paypalAllowedCurrencies=[
"AUD", "BRL", "CAD", "CZK", "DKK", "EUR", "HKD", "HUF", "INR", "ILS", "JPY", "MYR",
"MXN", "TWD", "NZD", "NOK", "PHP", "PLN", "GBP", "RUB", "SGD", "SEK", "CHF", "THB", "USD",];


Map paypalRedirectUrls={
  "return_url": "http://example.com/success",
  "cancel_url": "http://example.com/cancel"
};


Map tapRedirectUrls={
  "url": "http://your_website.com/redirect_url"
};

Map<String,dynamic> getConfigPaypal(double amount,double shippingAmount,String currencyCode){
  var formater = new NumberFormat("###.00", "en_US");
  var total=formater.format(amount+shippingAmount);
  var fixedAmount=formater.format(amount);
  var fixedShipping=formater.format(shippingAmount);

  String currency=paypalAllowedCurrencies.contains(currencyCode)?currencyCode:"USD";

//  fixedShipping=num.parse((shippingAmount).toStringAsFixed(2));
  Map<String,dynamic> paypalPaymentBody={
    "intent": "sale",
    "payer": {
      "payment_method": "paypal"
    },
    "transactions": [{
      "amount": {
        "total": "${total}",
        "currency": "$currency",
        "details": {
          "subtotal": "$fixedAmount",
          "tax": "0.00",
          "shipping": "$fixedShipping",
          "handling_fee": "0.00",
          "shipping_discount": "0.00",
          "insurance": "0.00"
        }
      },

      "description": "WooCommerce Shopping >Description.",
      "custom": "This is a hidden value",
      "invoice_number": Random().nextInt(9000),

      "soft_descriptor": "WooCommerce Order >Description",
      "item_list": {
        "items": [{
          "name": "Item 1",
          "description": "add description here",
          "quantity": "1",
          "price": "${fixedAmount}",
          "sku": "1",
          "currency": "$currency"
        }
        ]
      }
    }],
    "note_to_payer": "Contact us for any questions on your order.",
    "redirect_urls": paypalRedirectUrls
  };

  return paypalPaymentBody;
}

Map<String,dynamic> getConfigTap(double amount,double shippingAmount,String currencyCode){

  Map<String,dynamic> tapPaymentBody={
    "amount": amount+shippingAmount,
    "currency": currencyCode,
    "threeDSecure": true,
    "save_card": true,
    "description": "WooCommerce Purchase",
    "statement_descriptor": "WooCommerce Purchase",

    "receipt": {
      "email": false,
      "sms": true
    },
    "customer": {
      "first_name": getCustomerDetailsPref().first_name,
      "middle_name": "",
      "last_name": getCustomerDetailsPref().last_name,
      "email": getCustomerDetailsPref().email,
      "phone": {
        "country_code": "965",
        "number": "50000000"
      }
    },
    "source": {
      "id": "src_all"
    },
    "post": {
      "url": "http://your_website.com/post_url"
    },
    "redirect": tapRedirectUrls
  };

//  String etest=json.encode(tapPaymentBody).toString();
  return tapPaymentBody;
}

getRazorPayConfig(double amount,double shippingAmount,String currencyCode){
  double total=(amount+shippingAmount)*100;

  return {
    'key': RAZORPAY_AUTH_KEY,
    'amount': total.toInt(),
    'currency': currencyCode,
    'name': getCustomerDetailsPref().first_name,
    'description': 'WooCommerce Purchase',
    'prefill': {
      'contact': '8888888888',
      'email': getCustomerDetailsPref().email
    }
  };
}