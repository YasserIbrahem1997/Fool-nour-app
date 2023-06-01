

class GetAllDokanVendors{
  late int id;
  late String store_name;
  late String banner;
  late bool trusted;
  late String gravatar;


  GetAllDokanVendors(this.id, this.store_name, this.banner, this.trusted, this.gravatar);

  GetAllDokanVendors.fromJson(Map<String, dynamic> json){
    id = json['id'];
    store_name = json['store_name'];
    banner = json['banner'];
    trusted = json['trusted'];
    gravatar = json['gravatar'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'store_name': store_name,
        'banner': banner,
        'trusted': trusted,
        'gravatar': gravatar,
      };
}
