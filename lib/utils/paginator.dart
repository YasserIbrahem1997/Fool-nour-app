import '../bloc/bloc_blogpost.dart';
import '../bloc/bloc_dashboard.dart';
import '../http/customhttprequest.dart';
import '../http/woohttprequest.dart';
import '../models/api/blogPosts/getBlogPosts.dart';
import '../models/api/coupon/getCoupons.dart';
import '../models/api/dashboard/getDashboard.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/dashboard/getDashboardCategory.dart';
import '../screens/blogPostListWidget.dart';
import '../screens/splashWidget.dart';
import '../dokan/screens/dokanVendorsWidget.dart';
import '../dokan/woohttprequest.dart';
import 'package:collection/collection.dart';

//------------------------------DASHBOARD------------------------------//
int dashboard_page=1;
Future<void> loadNewDashboardData() async {
  GetDashboard? value= await CustomHttpRequest().getDashboard(dashboard_page);
  if (value != null) {
    refreshNewDashboardData(value);
    dashboardBloc.refreshDashboards(true);
  }
}
refreshNewDashboardData(GetDashboard _dashboard){
  if(totalProducts==null)
    totalProducts=[];
  if(totalCategories==null)
    totalCategories=[];

  currencyCode=_dashboard.currency_code;
  // currencySymbol=_dashboard.currency_symbol;

  // totalCategoryCount=_dashboard.total_categories;

  featured_products=_dashboard.featured_products;
  sales_products=_dashboard.sales_products;
  top_selling_products=_dashboard.top_selling_products;

  _dashboard.products.forEach((item) {
    var alreadyExistItem= totalProducts!.firstWhereOrNull((element) => element.id==item.id );
    if (alreadyExistItem==null)
      totalProducts!.add(item);
  });
  _dashboard.categories.forEach((item) {
    var alreadyExistItem= totalCategories!.firstWhereOrNull((element) => element.id==item.id );
    if (alreadyExistItem==null)
      totalCategories!.add(item);
  });
  dashboardBloc.refreshDashboards(true);
}


//------------------------------DASHBOARD------------------------------//
int blogpost_page=1;
Future<void> loadNewBlogsData() async {
  List<GetBlogPosts>? value= await WooHttpRequest().getBlogPosts();
  if (value != null) {
    refreshNewBlogPostData(value);
  }
}
refreshNewBlogPostData(List<GetBlogPosts> _blogPostList){
  if(blogPostList==null)
    blogPostList=[];

  _blogPostList.forEach((item) {
    var alreadyExistItem= blogPostList!.firstWhereOrNull((element) => element.id==item.id );
    if (alreadyExistItem==null)
      blogPostList!.add(item);
  });
}
