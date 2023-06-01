import 'dart:async';
import '../emuns/checkOutType.dart';
import '../models/api/order/getOrders.dart';

class TopSellingProductBloc{

  //-------------------------------------- SELECTIONS -------------------------------------//
//  order selection
  final selectTopSellingProductStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get selectTopSellingProductType_sink => selectTopSellingProductStreamController.sink;
  Stream<bool> get selectTopSellingProductType_counter => selectTopSellingProductStreamController.stream;

  refreshTopSellingProduct(bool isDataFetched){
    selectTopSellingProductType_sink.add(isDataFetched);
  }

}

final TopSellingProductBloc topSellingProductBloc=new TopSellingProductBloc();