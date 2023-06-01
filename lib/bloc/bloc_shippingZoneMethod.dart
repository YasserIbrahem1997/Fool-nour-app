import 'dart:async';

import '../models/api/shippingZoneMethod/getShippingZoneMethods.dart';
import '../models/api/shippingZone/getShippingZone.dart';

class ShippingZoneMethodBloc{

  //-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get shippingZoneMethods
  final getShippingZoneMethodsStreamController = StreamController<List<GetShippingZoneMethods>>.broadcast();
  StreamSink<List<GetShippingZoneMethods>> get getShippingZoneMethods_sink => getShippingZoneMethodsStreamController.sink;
  Stream<List<GetShippingZoneMethods>> get getShippingZoneMethods_counter => getShippingZoneMethodsStreamController.stream;

  refreshShippingZoneMethods(List<GetShippingZoneMethods> shippingZoneMethods){
    getShippingZoneMethods_sink.add(shippingZoneMethods);
  }

}

final ShippingZoneMethodBloc shippingZoneMethodBloc=new ShippingZoneMethodBloc();