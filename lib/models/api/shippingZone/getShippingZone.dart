
class GetShippingZone{
  int id;
  String name;


  GetShippingZone(this.id, this.name);

  GetShippingZone.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name']
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
      };
}

