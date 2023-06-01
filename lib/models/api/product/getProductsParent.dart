
class GetProductsParent{
  late int id;
  late String title;
  late String status;
  late bool featured;
  late String description;
  late String short_description;
  late String price;
  late String regular_price;
  late String sale_price;
  late bool on_sale;
  late bool in_stock;
  late int total_sales;
  late String average_rating;
  late int rating_count;
  late List<int> related_ids;
  late List<Images> images;
  late List<ProductAttributes> attributes;
  late List<Variations> variations;

  GetProductsParent.withObject(GetProductsParent getProductsParent){
    this.id=getProductsParent.id;
    this.title = getProductsParent.title;
    this.status = getProductsParent.status;
    this.featured = getProductsParent.featured;
    this.description = getProductsParent.description;
    this.short_description = getProductsParent.short_description;
    this.price = getProductsParent.price;
    this.regular_price = getProductsParent.regular_price;
    this.sale_price = getProductsParent.sale_price;
    this.on_sale = getProductsParent.on_sale;
    this.in_stock = getProductsParent.in_stock;
    this.total_sales = getProductsParent.total_sales;
    this.average_rating = getProductsParent.average_rating;
    this.rating_count = getProductsParent.rating_count;
    this.related_ids = getProductsParent.related_ids;
    this.images = getProductsParent.images;
    this.attributes = getProductsParent.attributes;
    this.variations = getProductsParent.variations;
  }


  GetProductsParent.withData(this.id, this.title, this.status, this.featured,
      this.description, this.short_description, this.price, this.regular_price,
      this.sale_price, this.on_sale, this.in_stock, this.total_sales, this.average_rating,
      this.rating_count, this.related_ids, this.images,
      this.attributes, this.variations  );

  GetProductsParent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['name']==null?json['title']:json['name'];
    status = json['status'];
    featured = json['featured'];
    description = json['description'];
    short_description = json['short_description'];
    price = json['price'].toString();
    regular_price = json['regular_price'].toString();
    sale_price = json['sale_price'];
    on_sale = json['on_sale'];
    in_stock = json['in_stock'];
    try{total_sales = json['total_sales'];}catch(ex){total_sales = int.parse(json['total_sales']);}
    average_rating = json['average_rating'];
    rating_count = json['rating_count'];
    related_ids = List<int>.from(json['related_ids'].map((data) => data).toList());
    images = List<Images>.from(json['images'].map((data) => Images.fromJson(data)).toList());
    attributes = List<ProductAttributes>.from(json['attributes'].map((data) => ProductAttributes.fromJson(data)).toList());
    variations = List<Variations>.from(json['variations'].map((data) => Variations.fromJson(data)).toList());
  }


  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'status': status,
        'featured': featured,
        'description': description,
        'short_description': short_description,
        'price': price,
        'regular_price': regular_price,
        'sale_price': sale_price,
        'on_sale': on_sale,
        'in_stock': in_stock,
        'total_sales': total_sales,
        'average_rating': average_rating,
        'rating_count': rating_count,
        'related_ids': related_ids,
        'images': images ,
        'attributes': attributes ,
        'variations': variations ,
      };
}

class Images{
  int id;
  String src;
  String name;


  Images(this.id, this.src, this.name);

  Images.fromJson(Map<String, dynamic> json):
        id = json['id'],
        src = json['src'] is bool?"":json['src'],
        name = json['name']
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'src': src,
        'name': name,
      };
}

class ProductAttributes{
  int id;
  String name;
  bool visible;
  List<String> options;


  ProductAttributes(this.id, this.name, this.visible, this.options);

  ProductAttributes.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json.containsKey("name")&& json['name']!=null?json['name']:"",
        visible = json['visible'],
        options = List<String>.from(json['options'].map((data) => data as String).toList())
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'visible': visible,
        'options': options,
      };
}


class Variations{
  int id;
  String sku;
  String price;
  String regular_price;
  String sale_price;
  int stock_quantity;
  bool in_stock;
  bool purchaseable;
  bool visible;
  bool on_sale;
  List<Images> images;
  List<VariationAttributes> attributes;


  Variations(this.id, this.sku, this.price, this.regular_price, this.sale_price,
      this.stock_quantity, this.in_stock, this.purchaseable, this.visible,
      this.on_sale, this.images, this.attributes);

  Variations.fromJson(Map<String, dynamic> json):
        id = json['id'],
        sku = json['sku'],
        price = json['price'],
        regular_price = json['regular_price'],
        sale_price = json['sale_price'],
        stock_quantity = json['stock_quantity']!=null?json['stock_quantity']:1,
        in_stock = json['in_stock'],
        purchaseable = json['purchaseable']!=null?json['purchaseable']:true,
        visible = json['visible'],
        on_sale = json['on_sale'],
        images = (json['image']==null)?[]:List<Images>.from(json['image'].map((data) => Images.fromJson(data)).toList()),
        attributes = (json['attributes']==null)?[]:List<VariationAttributes>.from(json['attributes'].map((data) => VariationAttributes.fromJson(data)).toList())
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'sku': sku,
        'price': price,
        'regular_price': regular_price,
        'sale_price': sale_price,
        'stock_quantity': stock_quantity,
        'in_stock': in_stock,
        'purchaseable': purchaseable,
        'visible': visible,
        'on_sale': on_sale,
        'images': images ,
        'attributes': attributes ,
      };
}

class VariationAttributes{
  String name;
  String option;


  VariationAttributes(this.name, this.option);

  VariationAttributes.fromJson(Map<String, dynamic> json):
        name = json['name'],
        option = json['option']
  {}

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'option': option,
      };
}
