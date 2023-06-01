import 'dart:async';

import '../emuns/checkOutType.dart';


class CheckOutBloc{

  //-------------------------------------- SELECTIONS -------------------------------------//
//  order selection
  final selectCheckoutStreamController = StreamController<CheckOutType>.broadcast();
  StreamSink<CheckOutType> get selectCheckOutType_sink => selectCheckoutStreamController.sink;
  Stream<CheckOutType> get selectCheckOutType_counter => selectCheckoutStreamController.stream;

  selectCheckOut(CheckOutType checkOutType){
    selectCheckOutType_sink.add(checkOutType);
  }

}

final CheckOutBloc checkOutBloc=new CheckOutBloc();