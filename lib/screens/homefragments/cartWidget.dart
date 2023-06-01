import 'package:cached_network_image/cached_network_image.dart';
import '/bloc/bloc_coupon.dart';
import '/list_views/cart_wishlist_horizontal_listview.dart';
import '/models/api/dashboard/getDashboardProducts.dart';
import '/models/api/product/getProductsParent.dart';
import '/http/woohttprequest.dart';
import 'package:flutter/material.dart';
import '/WidgetHelper/ToastUtils.dart';
import '/emuns/coupon.dart';
import '/main.dart';
import '/models/api/order/createOrderModel.dart';
import '/models/api/coupon/getCoupons.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/commonMethod.dart';
import '/utils/consts.dart';
import '/utils/languages_local.dart';
import '/utils/prefrences.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatefulWidget {
  bool showAppBar = false;

  CartScreen(this.showAppBar);

  @override
  _CartScreenState createState() => new _CartScreenState();
}

List<GetAllCoupon>? coupons;

class _CartScreenState extends State<CartScreen> {
  int REFRESHDELAY = 1;
  List<Line_items>? cartList;
  CouponSelection couponSelection = CouponSelection.TextField;
  TextEditingController couponController = TextEditingController();
  TextEditingController qController = TextEditingController();
  GetAllCoupon? _coupon = null;
  double totalCost = 0;
  String? itemPriceText;
  String msg = '';
  String? itemSubtotalText;
  double price = 0.0;
  TimeOfDay open = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay close = TimeOfDay(hour: 00, minute: 00);
  List<TimeOfDay> openingTimeRange = [];


  bool showWishList = false;

  @override
  void initState() {
    super.initState();

    WooHttpRequest().getCoupon().then((value) {
      coupons = value;
      couponBloc.refreshCoupons(coupons!);
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) => scrollToTop());

    FirebaseFirestore.instance
        .collection('Settings')
        .doc('working_hours')
        .get()
        .then((value) {
          open = TimeOfDay(hour: int.parse(value['open'].split(":")[0]), minute: int.parse(value['open'].split(":")[1]));
          close = TimeOfDay(hour: int.parse(value['close'].split(":")[0]), minute: int.parse(value['close'].split(":")[1]));
          msg = value['msg'];
          openingTimeRange = [open,close];
          print('o/c');
          print(openingTimeRange);
          setState(() {
          });
    });

  }


  bool isOpen(List<TimeOfDay> openingTimeRange) {
    TimeOfDay now = TimeOfDay.now();
    print('is open');
    print(openingTimeRange);
    print(now);

    return now.hour >= openingTimeRange[0].hour
        && now.hour <= openingTimeRange[1].hour;
  }

  scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments;
    if (map != null && (map as Map).containsKey("_showAppBar"))
      widget.showAppBar = map['_showAppBar'];

    cartList = getCartProductsPref().reversed.toList();
    totalCost = 0.0;

    return Scaffold(
        backgroundColor: BackgroundColor,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  Widget body() {
    return Container(
        child: widget.showAppBar
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: BackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_back,
                                color: MainHighlighter,
                                size: 25,
                              ),
                            )),
                        Text(
                          LocalLanguageString().productscart,
                          style: TextStyle(
                            color: MainHighlighter,
                            fontSize: 22.0,
                            fontFamily: "Header",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  getSafeBodyArea()
                ],
              )
            : getSafeBodyArea());
  }

  ScrollController _scrollController = new ScrollController();

  Widget getSafeBodyArea() {
    double wishListHeight = 100;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height * 0.59) -
                            (showWishList ? wishListHeight : 0),
                        child: ListView.builder(
                          itemCount: cartList!.length,
                          controller: _scrollController,
                          itemBuilder: (context, int index) {
                            return cartItems(cartList![index], index);
                          },
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showWishList = true;
                      //       setState(() {});
                      //     },
                      //     child: Container(
                      //         decoration: BoxDecoration(
                      //             color: MainHighlighter,
                      //             borderRadius: BorderRadius.only(
                      //               bottomLeft: Radius.circular(15.0),
                      //             )
                      //         ),
                      //         height: 35,
                      //         width: 150,
                      //         alignment: Alignment.center,
                      //         child: Text(
                      //           LocalLanguageString().addtowishlist,
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             fontFamily: "Header",
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 13,
                      //             color: BackgroundColor,
                      //           ),
                      //         )
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  showWishList
                      ? Container(
                          height: wishListHeight,
                          child: Stack(
                            children: [
                              WishListWidget()
                                  .getWishListView(context, showWishList, () {
                                setState(() {});
                              }),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Stack(
                                    children: [
                                      IconButton(
                                        color: SecondaryHighlighter,
                                        icon: Icon(
                                          Icons.circle,
                                          color: BackgroundColor,
                                        ),
                                        iconSize: 30,
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        color: SecondaryHighlighter,
                                        icon: Icon(
                                          Icons.cancel,
                                          color: MainHighlighter,
                                        ),
                                        iconSize: 30,
                                        onPressed: () {
                                          showWishList = false;
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  )),
                            ],
                          ))
                      : Container()
                ],
              ),
            ),
            _checkoutSection(context,openingTimeRange,msg),
          ],
        ),
      ),
    );
  }

  double boxSize = 70;

  Widget cartItems(Line_items item, int index) {
    GetDashBoardProducts getproduct = item.productDetail;
    Variations? variant = null;
    if (getproduct == null) return Container();

    variant = item.variation_id == -1
        ? null
        : getproduct.variations.firstWhere(
            (element) => element.id == item.variation_id,
            orElse: null);

    String? image = null;
    if (variant != null)
      image = variant != null
          ? variant.images.length > 0
              ? variant.images[0].src
              : null
          : null;
    else
      image = getproduct != null
          ? getproduct.images.length > 0
              ? getproduct.images[0].src
              : null
          : null;
    if (variant != null)
      price = variant.price == "" ? 0 : price = double.parse(variant.price);
    else
      price = getproduct.price == "" ? 0 : double.parse(getproduct.price);

    itemPriceText = LocalLanguageString().price +
        " :" +
        " ${price} ${currencyCode == null ? "" : currencyCode} ";
    itemSubtotalText = LocalLanguageString().subtotal +
        " :" +
        " ${price * item.quantity} ${currencyCode == null ? "" : currencyCode} ";

    if (couponSelection == CouponSelection.Accepted &&
        _coupon != null &&
        (!_coupon!.exclude_sale_items ||
            (_coupon!.exclude_sale_items && !getproduct.on_sale))) {
      {
        bool couponAppicableOnProduct =
            isValidTokenForProduct(_coupon!, getproduct);
        bool couponAppicableOnCateogory =
            isValidTokenForP_Category(_coupon!, getproduct.categories);

        print("");
        if (couponAppicableOnCateogory || couponAppicableOnProduct) {
          if (_coupon!.discount_type == "fixed_product")
            price = (price - double.parse(_coupon!.amount)) <= 0
                ? 0
                : (price - double.parse(_coupon!.amount));

          totalCost += (price * item.quantity);

          if (_coupon!.discount_type == "fixed_cart" &&
              index == cartList!.length - 1)
            totalCost = (totalCost - double.parse(_coupon!.amount)) <= 0
                ? 0
                : (totalCost - double.parse(_coupon!.amount));
          else if (_coupon!.discount_type == "percent" &&
              index == cartList!.length - 1)
            totalCost = (totalCost -
                        (double.parse(_coupon!.amount) / 100) * totalCost) <=
                    0
                ? 0
                : (totalCost -
                    (double.parse(_coupon!.amount) / 100) * totalCost);

          itemPriceText = LocalLanguageString().price +
              " :" +
              " ${price} ${currencyCode == null ? "" : currencyCode} ";
          itemSubtotalText = LocalLanguageString().subtotal +
              " :" +
              " ${price * item.quantity} ${currencyCode == null ? "" : currencyCode} ";
        } else
          totalCost += (price * item.quantity);
      }
    } else
      totalCost += (price * item.quantity);

    int tempchanged = 0;
    print(item.comment);

    return Container(
      height: 140,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: transparent,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 80,
              padding: EdgeInsets.all(3),
              child: image != null
                  ? CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                          child: Container(
                        child: CircularProgressIndicator(),
                        height: 30,
                        width: 30,
                      )),
                      //JumpingDotsProgressIndicator(fontSize: 20.0,)
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.filter_b_and_w),
                      ),
                    )
                  : Container(
                      height: 60,
                      width: 60,
                    )),
          Container(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${getproduct != null ? getproduct.title != null ? getproduct.title : "" : ""}"
                            .toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: MainHighlighter,
                            fontSize: 16,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          delCartProductsPref(
                                  item.product_id, item.variation_id)
                              .then((isdeleted) {
                            setState(() {});
                          });
                        },
                        color: MainHighlighter,
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        iconSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemPriceText!,
                        style: TextStyle(
                            color: NormalColor,
                            fontSize: 13,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        itemSubtotalText!,
                        style: TextStyle(
                          color: MainHighlighter,
                          fontSize: 12,
                          fontFamily: "Normal",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Card(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Container(
                                  width: 35,
                                  child: Center(
                                    child: TextFormField(
                                      initialValue: item.quantity.toString(),
                                      onChanged: (value) {
                                        tempchanged = int.parse(value);
                                        item.quantity = tempchanged;
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      // Only numbers can be entered

                                      onEditingComplete: () {
                                        item.quantity = tempchanged;
                                        addORupdateCartProductsPref(item)
                                            .then((isUpdated) {
                                          setState(() {});
                                        });
                                      },

                                      decoration: InputDecoration(
                                        isDense: true,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontFamily: "Header",
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                // Text(
                                //   "${item.quantity}",
                                //   style: TextStyle(
                                //       fontFamily: "Normal",
                                //       color: MainHighlighter,
                                //
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w700
                                //   ),
                                ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _checkoutSection(BuildContext context, List<TimeOfDay> openingTimeRange, String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 1,
          color: NormalColor,
        ),
        StreamBuilder(
          stream: couponBloc.getCouponStreamController.stream,
          initialData: coupons,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data != null
                ? getCoupon()
                : Center(
                    child: JumpingDotsProgressIndicator(
                    fontSize: 30.0,
                  ));
          },
        ),
        Container(
            margin: EdgeInsets.all(7),
            child: Row(
              children: <Widget>[
                Text(
                  LocalLanguageString().checkoutprice + " :",
                  style: TextStyle(
                    color: NormalColor,
                    fontFamily: "Normal",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                FutureBuilder(
                    future: getTotalPrice(),
                    initialData: "Loading ..",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return Text(
                        text.data!,
                        style: TextStyle(
                          color: NormalColor,
                          fontFamily: "Normal",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    })
              ],
            )),
        GestureDetector(
          onTap: () {
            if (totalCost > 0) {
              Future.delayed(Duration(seconds: REFRESHDELAY), () {
                bool isFreeShipment =
                    (couponSelection == CouponSelection.Accepted &&
                        _coupon != null &&
                        _coupon!.free_shipping);
                print('is open');
                print(isOpen(openingTimeRange));
                if(isOpen(openingTimeRange)) {
                  if (prefs!.getBool(ISLOGIN) ?? false) {
                    Navigator.pushNamed(context, '/checkOutTab', arguments: {
                      '_amount': totalCost,
                      '_freeShipment': isFreeShipment
                    });
                  } else
                    Navigator.pushNamed(context, '/login', arguments: {
                      '_amount': totalCost,
                      '_freeShipment': isFreeShipment,
                      '_nextToGo': "/checkOutTab"
                    });
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                  ));
                }
              });
            } else
              ToastUtils.showCustomToast(
                  context, "Cart price must not be zero");
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                LocalLanguageString().checkout,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Header",
                    letterSpacing: 1.2,
                    color: MainHighlighter,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget getCoupon() {
    if (couponSelection == CouponSelection.TextField)
      return Row(
        children: [
          Container(
            margin: EdgeInsets.all(7),
            width: MediaQuery.of(context).size.width / 3,
            child: TextFormField(
              controller: couponController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  labelText: LocalLanguageString().entercoupon,
                  labelStyle: TextStyle(color: Colors.white60)
                  //fillColor: Colors.green
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _coupon = coupons!.firstWhereOrNull((element) =>
                  element.code.toLowerCase() ==
                  couponController.text.toLowerCase());
              if (_coupon != null) {
                double minimum_amount = double.parse(
                    _coupon!.minimum_amount != null &&
                            _coupon!.minimum_amount != ""
                        ? _coupon!.minimum_amount
                        : "0.0");
                double maximum_amount = double.parse(
                    _coupon!.maximum_amount != null &&
                            _coupon!.maximum_amount != ""
                        ? _coupon!.maximum_amount
                        : "0.0");
                bool inAmountInCouponRange =
                    totalCost > minimum_amount && totalCost < maximum_amount;
                bool isDateNotPassed = _coupon!.date_expires == null
                    ? true
                    : DateTime.now().isBefore(
                        DateTime.parse(_coupon!.date_expires).toLocal());
                bool isUsageInLimit =
                    _coupon!.usage_count < _coupon!.usage_limit;

                print("");
                if (isDateNotPassed &&
                    isUsageInLimit &&
                    inAmountInCouponRange) {
                  couponSelection = CouponSelection.Accepted;
                  print("");
                }
              } else {
                couponSelection = CouponSelection.ErrorMessage;
              }
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocalLanguageString().apply,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Header",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: NormalColor,
                ),
              ),
            ),
          )
        ],
      );
    if (couponSelection == CouponSelection.ErrorMessage)
      return Container(
        margin: EdgeInsets.all(7),
        child: Row(
          children: [
            Text(
              LocalLanguageString().couponnotfound,
              style: TextStyle(
                fontFamily: "Normal",
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: NormalColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                couponSelection = CouponSelection.TextField;
                setState(() {});
              },
              child: Text(
                LocalLanguageString().reentercoupon,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: "Header",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: NormalColor,
                ),
              ),
            )
          ],
        ),
      );
    if (couponSelection == CouponSelection.Accepted)
      return Container(
          margin: EdgeInsets.all(7),
          child: Text(
            LocalLanguageString().couponapplied,
            style: TextStyle(
              fontFamily: "Header",
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: NormalColor,
            ),
          ));
    else
      return Container();
  }

  Future<String> getTotalPrice() {
    return Future.delayed(
        Duration(seconds: REFRESHDELAY), () => totalCost.toString());
  }
}
