import 'dart:async';

import '../models/api/coupon/getCoupons.dart';


class CouponBloc{

  //-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get coupons
  final getCouponStreamController = StreamController<List<GetAllCoupon>>.broadcast();
  StreamSink<List<GetAllCoupon>> get getCoupon_sink => getCouponStreamController.sink;
  Stream<List<GetAllCoupon>> get getCoupon_counter => getCouponStreamController.stream;

  refreshCoupons(List<GetAllCoupon> coupons){
    getCoupon_sink.add(coupons);
  }


}

final CouponBloc couponBloc=new CouponBloc();