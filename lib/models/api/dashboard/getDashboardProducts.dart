
import 'package:flutter/material.dart';

import '/models/api/dashboard/getDashboardCategory.dart';
import '/models/api/product/getProductsParent.dart';

class GetDashBoardProducts extends GetProductsParent {
  late List<GetDashboardCategories> categories;
  late List<Tag> tags;
  late String vendor_id;

  GetDashBoardProducts(
      int id,
      String title,
      String status,
      bool featured,
      String description,
      String short_description,
      String price,
      String regular_price,
      String sale_price,
      bool on_sale,
      bool in_stock,
      int total_sales,
      String average_rating,
      int rating_count,
      List<int> related_ids,
      String categories,
      String tags,
      List<Images> images,
      List<ProductAttributes> attributes,
      List<Variations> variations)
      : super.withData(
            id,
            title,
            status,
            featured,
            description,
            short_description,
            price,
            regular_price,
            sale_price,
            on_sale,
            in_stock,
            total_sales,
            average_rating,
            rating_count,
            related_ids,
            images,
            attributes,
            variations);

  set vendorId(String _vendor_id) {
    vendor_id = _vendor_id;
  }

  GetDashBoardProducts.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {

    categories = json['categories'] == null
        ? []
        : List<GetDashboardCategories>.from(json['categories']
            .map((data) => GetDashboardCategories.fromJson(data))
            .toList());
    tags =
        List<Tag>.from(json['tags'].map((data) => Tag.fromJson(data)).toList());
    vendor_id = json.containsKey("vendor_id") ? json['vendor_id'] : "0";
  }

  GetDashBoardProducts.fromJsonIgnoreNull(Map<String, dynamic> json)
      : super.fromJson(json) {
    categories = json['categories'] == null
        ? []
        : List<GetDashboardCategories>.from(json['categories']
            .map((data) => GetDashboardCategories.fromJson(data))
            .toList());
    tags = json['tags'] == null
        ? []
        : List<Tag>.from(
            json['tags'].map((data) => Tag.fromJson(data)).toList());
    vendor_id = json.containsKey("vendor_id") ? json['vendor_id'] : "0";
  }

  Map<String, dynamic> toJson() => {
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
        'images': images,
        'attributes': attributes,
        'variations': variations,
        'categories': categories,
        'tags': tags,
      };
}

class Tag {
  late int id;
  late String name;
  late String slug;

  Tag(this.id, this.name, this.slug);

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
      };
}
