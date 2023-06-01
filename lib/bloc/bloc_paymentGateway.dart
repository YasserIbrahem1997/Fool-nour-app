import 'dart:async';

import '../models/api/paymentMethod/getPaymentMethods.dart';

class PaymentGatewayBloc{

  //-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get paymentGateways
  final getPaymentGatewayStreamController = StreamController<List<GetPaymentGateway>>.broadcast();
  StreamSink<List<GetPaymentGateway>> get getPaymentGateway_sink => getPaymentGatewayStreamController.sink;
  Stream<List<GetPaymentGateway>> get getPaymentGateway_counter => getPaymentGatewayStreamController.stream;

  refreshPaymentGateways(List<GetPaymentGateway> paymentGateways){
    getPaymentGateway_sink.add(paymentGateways);
  }


}

final PaymentGatewayBloc paymentGatewayBloc=new PaymentGatewayBloc();