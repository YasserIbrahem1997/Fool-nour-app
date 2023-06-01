

class GetAllWcfmVendors{
  late int vendor_id;
  late String vendor_display_name;
  late String vendor_shop_name;
  late String formatted_display_name;
  late String vendor_shop_logo;
  late String vendor_banner_type;
  late String vendor_banner;
  late bool is_store_offline;


  GetAllWcfmVendors(this.vendor_id, this.vendor_display_name, this.vendor_shop_name, this.formatted_display_name,
      this.vendor_shop_logo, this.vendor_banner_type, this.vendor_banner, this.is_store_offline);

  GetAllWcfmVendors.fromJson(Map<String, dynamic> json){
    vendor_id = json['vendor_id'];
    vendor_display_name = json['vendor_display_name'];
    vendor_shop_name = json['vendor_shop_name'];
    formatted_display_name = json['formatted_display_name'];
    vendor_shop_logo = json['vendor_shop_logo'];
    vendor_banner_type = json['vendor_banner_type'];
    vendor_banner = json['vendor_banner'];
    is_store_offline = json['is_store_offline']=="no"?false:true;
  }

  Map<String, dynamic> toJson() =>
      {
        'vendor_id': vendor_id,
        'vendor_display_name': vendor_display_name,
        'vendor_shop_name': vendor_shop_name,
        'formatted_display_name': formatted_display_name,
        'vendor_shop_logo': vendor_shop_logo,
        'vendor_banner_type': vendor_banner_type,
        'vendor_banner': vendor_banner,
        'is_store_offline': is_store_offline,
      };
}
