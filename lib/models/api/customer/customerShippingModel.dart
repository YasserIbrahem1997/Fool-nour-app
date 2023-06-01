
class Shipping{
  String first_name;
  String last_name;
  String company;
  String address_1;
  String address_2;
  String city;
  String state;
  String postcode;
  String country;
  Shipping(this.first_name, this.last_name, this.company, this.address_1, this.address_2, this.city, this.state, this.postcode, this.country);

  Shipping.fromJson(Map<String, dynamic> jsonData):
        first_name = jsonData['first_name'] ?? "",
        last_name = jsonData['last_name'] ?? "",
        company = jsonData['company'] ?? "",
        address_1 = jsonData['address_1'] ?? "",
        address_2 = jsonData['address_2'] ?? "",
        city = jsonData['city'] ?? "",
        state = jsonData['state'] ?? "",
        postcode = jsonData['postcode'] ?? "",
        country = jsonData['country'] ?? ""
  {}

  Map<String, dynamic> toJson() =>
      {
        'first_name': first_name,
        'last_name': last_name,
        'company': company,
        'address_1': address_1,
        'address_2': address_2,
        'city': city,
        'state': state,
        'postcode': postcode,
        'country': country,
      };
}
