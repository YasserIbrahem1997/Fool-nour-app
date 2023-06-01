
import 'getDashboardCategory.dart';
import 'getDashboardProducts.dart';

class GetDashboard{
  late List<GetDashboardCategories> categories;
  late List<GetDashBoardProducts> products;
  late List<GetDashBoardProducts> featured_products;
  late List<GetDashBoardProducts> sales_products;
  late List<GetDashBoardProducts> top_selling_products;
  // late int total_products;
  // late int total_categories;
  late String currency_symbol;
  late String currency_code;

  GetDashboard(this.categories, this.products);

  GetDashboard.fromJson(Map<String, dynamic> json){
    categories = json['categories']==null?[]:List<GetDashboardCategories>.from(json['categories'].map((data) => GetDashboardCategories.fromJson(data)).toList());
    products = json['products']==null?[]:List<GetDashBoardProducts>.from(json['products'].map((data) => GetDashBoardProducts.fromJson(data)).toList());
    featured_products = json['featured_products']==null?[]:List<GetDashBoardProducts>.from(json['featured_products'].map((data) => GetDashBoardProducts.fromJson(data)).toList());
    top_selling_products = json['top_selling_products']==null?[]:List<GetDashBoardProducts>.from(json['top_selling_products'].map((data) => GetDashBoardProducts.fromJson(data)).toList());
    sales_products = json['sales_products']==null?[]:List<GetDashBoardProducts>.from(json['sales_products'].map((data) => GetDashBoardProducts.fromJson(data)).toList());
    // total_products = json['total_products'];
    // total_categories = json['total_categories'];
    currency_symbol = json['currency_symbol']!=null?json['currency_symbol']:"";
    currency_code = json['currency_code']!=null?json['currency_code']:"";
   }

  Map<String, dynamic> toJson() =>
      {
        'categories': categories.map((index) => index.toJson()),
        'products': products.map((index) => index.toJson()),
        'featured_products': featured_products.map((index) => index.toJson()),
        'sales_products': sales_products.map((index) => index.toJson()),
        'top_selling_products': top_selling_products.map((index) => index.toJson()),
        // 'total_products': total_products,
        // 'total_categories': total_categories,
        'currency_symbol': currency_symbol,
        'currency_code': currency_code,
      };
}
