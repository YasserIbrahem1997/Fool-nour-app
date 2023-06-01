import '/wcfm/holders/wcfmvendors_grid_item.dart';
import '/wcfm/models/api/vendor/getAllWcfmVendorsResponceModel.dart';
import '/wcfm/screens/subProducts/subProduct_WcfmVendorProductWidget.dart';
import 'package:flutter/material.dart';

class TrustedWcfmVendorGridView {

  Widget getGridView(BuildContext context, List<GetAllWcfmVendors> vendors, Function refresh) {
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubProduct_WcfmVendorProductScreen(vendors[index].vendor_id, vendors[index].vendor_shop_name)));
          },
          child: WcfmVendorListItem().itemView(vendors[index],refresh),
        );
      },
    ) : Container();
  }
}
