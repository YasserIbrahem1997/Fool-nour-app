import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/api/order/getOrders.dart';
import '../utils/consts.dart';
import '../utils/prefrences.dart';
import 'get_ordere_statrs.dart';

class GetAllOrderCubit extends Cubit<GetAllOrderStates> {
  final Reposetry getDataFromRepo ;
  GetAllOrderCubit(this.getDataFromRepo) : super(AuthInitialztionStates());

  // static GetAllOrderCubit get(context) =>
  //     BlocProvider.of<GetAllOrderCubit>(context);

  Future<void> fetchDataOrder() async{
    emit(GetAllOrderStatesLoading());
    print("im here now");
    try{
      final respons = await getDataFromRepo.aftchOrdare();
      emit(GetAllOrderStatesSuccess(respons));
    }catch(e){
      emit(GetAllOrderErrorStates(e.toString()));
      print( "this errrrr ${GetAllOrderErrorStates(e.toString())}");
    }
  }
  // Future<List<GetOrderResponce>> getOrders() async {
  //   String basicAuth = 'Basic ${base64Encode(utf8.encode('$WOOCOMM_AUTH_USER:$WOOCOMM_AUTH_PASS'))}';
  //   String customAppenderAuth =
  //       "&consumer_key=$WOOCOMM_AUTH_USER&consumer_secret=$WOOCOMM_AUTH_PASS";
  //   print(basicAuth);
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     // "Authorization": basicAuth
  //   };
  //
  //   final response = await http.get(
  //       Uri.parse(WP_JSON_WC + "orders?$customAppenderAuth"),
  //       headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     List responseJson = json.decode(response.body);
  //     List<GetOrderResponce> listResponce =
  //     responseJson.map((data) => GetOrderResponce.fromJson(data)).toList();
  //     for (var data in listResponce) {
  //       if (data.billing.email == getCustomerDetailsPref().email) {
  //         print('order: ');
  //         print(tempListResponce.length.toString());
  //         print(data.id);
  //         tempListResponce.add(data);
  //       }
  //     }
  //     return tempListResponce;
  //   } else {
  //     return [];
  //   }
  // }

}
class Reposetry{
  Future<List<GetOrderResponce>> aftchOrdare() async {
    // emit(GetAllOrderStatesLoading());
    // List<GetOrderResponce> tempListResponce = [];
    var url = Uri.parse("https://nourrestaurant.com/wp-json/wc/v3/orders/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<GetOrderResponce> listResponce =
      responseJson.map((data) => GetOrderResponce.fromJson(data)).toList();
      List<GetOrderResponce> _tempListResponce = [];
      listResponce.forEach((data) {
          print('order: ');
          print(data.id);
          _tempListResponce.add(data);

      });
      return _tempListResponce;
    } else{
      throw "somthing errore code ${response.statusCode}";
    }

    // for (var data in responsBody) {
    //   tempListResponce.add(GetOrderResponce(
    //       data["id"],
    //       data["order_key"],
    //       data["status"],
    //       data["total"],
    //       data['total_tax'],
    //       data ["customer_id"],
    //       data ["payment_method_title"],
    //       data ["transaction_id"],
    //       data ["billing"],
    //       data ["shipping"],
    //       data ["line_items"]));
    // }
    // emit(GetAllOrderStatesSuccess());
    // print( " thiiiiiiis $tempListResponce");
    // return tempListResponce;
  }

}