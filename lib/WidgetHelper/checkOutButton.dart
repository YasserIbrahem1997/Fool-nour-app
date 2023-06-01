import 'package:flutter/material.dart';
import '../emuns/checkOutType.dart';
import '../utils/appTheme.dart';

class CheckOutButton {
  Widget getCheckOutTab(CheckOutType checkOutType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: []..addAll(CheckOutType.values.map((type) {
          return getButtonUI(type, type == checkOutType);
        }).toList()),
    );
  }

  Widget getButtonUI(CheckOutType checkOutType, bool isSelected) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 90,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Center(
          child: Text(
            checkOutType.toString().split(".")[1] == 'ADDRESS'
                ? 'العنوان'
                : checkOutType.toString().split(".")[1] == 'PAYMENT'
                    ? 'الدفع'
                    : 'الشحن',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              fontFamily: "Normal",
              color: isSelected ? MainHighlighter : NormalColor,
            ),
          ),
        ),
      ),
    );
  }
}
