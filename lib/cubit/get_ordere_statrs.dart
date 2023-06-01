
import '../models/api/order/getOrders.dart';

abstract class GetAllOrderStates {}
class AuthInitialztionStates extends GetAllOrderStates{}

class GetAllOrderStatesLoading extends GetAllOrderStates{}
class GetAllOrderStatesSuccess extends GetAllOrderStates{
  List<GetOrderResponce> DataOrdere;
  GetAllOrderStatesSuccess(this.DataOrdere);
}
class GetAllOrderErrorStates extends GetAllOrderStates{
  final String MaError;
  GetAllOrderErrorStates(this.MaError);
}
