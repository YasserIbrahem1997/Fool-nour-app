import '../holders/product_grid_item.dart';
import '../models/api/dashboard/getDashboardProducts.dart';
import 'package:flutter/material.dart';

class ProductGridView {

  Widget getGridView(BuildContext context, List<GetDashBoardProducts> products, Function refresh) {
    return products.length>0?GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.65,//w/h
        ),
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/homeproductdetail', arguments: {'_product': products[index]});
            },
            child: ProductListItem_Grid().itemView(products[index],index,refresh),
          );
        }
    ) :Container();

  }
}
