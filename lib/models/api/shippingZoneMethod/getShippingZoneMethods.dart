
class GetShippingZoneMethods{
  int id;
  String title;
  bool enabled;
  String method_id;
  String method_description;
  String cost;


  GetShippingZoneMethods(this.id, this.title, this.enabled, this.method_id, this.method_description, this.cost);

  GetShippingZoneMethods.fromJson(Map<String, dynamic> json):
        id = json['id'],
        title = json['title'],
        enabled = json['enabled'],
        method_id = json['method_id'],
        method_description = json['method_description'],
        cost = json['settings'].containsKey("cost")?
          json['settings']["cost"]["value"]!=""?json['settings']["cost"]["value"]:"0":"0"
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'enabled': enabled,
        'method_id': method_id,
        'method_description': method_description,
        'cost': cost,
      };
}

