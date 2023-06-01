

class GetPaymentGateway{
  String id;
  String title;
  String description;
  bool enabled;


  GetPaymentGateway(this.id, this.title, this.description, this.enabled);

  GetPaymentGateway.fromJson(Map<String, dynamic> json):
        id = json['id'],
        title = json['title']==null?"":json['title'],
        description = json['description']==null?"":json['description'],
        enabled = json['enabled']
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'description': description,
        'enabled': enabled,
      };
}

