import 'dart:async';

import '../models/api/shippingZone/getShippingZone.dart';

class ShippingZoneBloc{

  //-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get shippingZones
  final getShippingZoneStreamController = StreamController<List<GetShippingZone>>.broadcast();
  StreamSink<List<GetShippingZone>> get getShippingZone_sink => getShippingZoneStreamController.sink;
  Stream<List<GetShippingZone>> get getShippingZone_counter => getShippingZoneStreamController.stream;

  refreshShippingZones(List<GetShippingZone> shippingZones){
    getShippingZone_sink.add(shippingZones);
  }


}

final ShippingZoneBloc shippingZoneBloc=new ShippingZoneBloc();