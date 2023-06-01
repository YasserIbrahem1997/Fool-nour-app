import '../screens/orderhistoryWidget.dart';
import 'package:flutter/material.dart';
import '../bloc/bloc_order.dart';
import '../emuns/orderType.dart';
import '../models/api/order/getOrders.dart';
import '../utils/appTheme.dart';

class OrderButton {

  OrderStatus? orderStatus;
  List<GetOrderResponce>? orders;
  Widget getOrderTypes(OrderStatus selectedOrderStatus) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: List<Widget>.generate(OrderStatus.values.length, (int index) {
        final int count = OrderStatus.values.length;
        return getButtonUI(OrderStatus.values[index],OrderStatus.values[index]==selectedOrderStatus);
      },
      ),
    );

  }

  Widget getButtonUI(OrderStatus orderStatus,bool isSelected) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 90,
      child: InkWell(
        onTap: () {
          List<GetOrderResponce> _temporder=new List.empty(growable: true);
          if(orderStatus==OrderStatus.any)
            _temporder=orders!;
          else
            orders!.forEach((order){
              if(order.status==orderStatus.toString().split(".")[1])
                _temporder.add(order);
            });

          orderBloc.refreshOrders(_temporder);
          orderBloc.selectOrderType(orderStatus);
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Center(
            child: Text(
              orderStatus.toString().split(".")[1]  == 'any' ? 'الكل':orderStatus.toString().split(".")[1]  == 'pending' ? 'في الإنتظار':orderStatus.toString().split(".")[1]  == 'processing' ? 'في التحضير':orderStatus.toString().split(".")[1]  == 'completed' ? 'مكتمل': '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: "Normal",
                color: isSelected?MainHighlighter:NormalColor,
              ),

            ),
          ),
        ),
      )
    );
  }
}