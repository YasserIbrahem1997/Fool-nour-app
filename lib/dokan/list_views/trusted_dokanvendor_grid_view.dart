import '/dokan/holders/dokanvendors_grid_item.dart';
import '/dokan/models/api/vendor/getAllDokanVendorsResponceModel.dart';
import '/dokan/screens/subProducts/subProduct_DokanVendorProductWidget.dart';
import 'package:flutter/material.dart';

class TrustedDokanVendorGridView {

  Widget getGridView(BuildContext context, List<GetAllDokanVendors> vendors, Function refresh) {
    return vendors.length > 0 ? GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.65, //w/h
      ),
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_DokanVendorProductScreen(vendors[index].id, vendors[index].store_name)));
          },
          child: DokanVendorListItem().itemView(vendors[index],refresh),
        );
      },
    ) : Container();
  }
}
