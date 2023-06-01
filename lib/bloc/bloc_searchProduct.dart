import 'dart:async';
import '../models/api/dashboard/getDashboardProducts.dart';

class SearchProductBloc {
  //get Search Products
  final getSearchProductStreamController =
      StreamController<List<GetDashBoardProducts>>.broadcast();

  StreamSink<List<GetDashBoardProducts>> get getSearchProduct_sink =>
      getSearchProductStreamController.sink;

  Stream<List<GetDashBoardProducts>> get getSearchProduct_counter =>
      getSearchProductStreamController.stream;

  refreshSearchProducts(List<GetDashBoardProducts>? _products) {
    if (_products != null) getSearchProduct_sink.add(_products);
  }
}

final SearchProductBloc searchProductBloc = new SearchProductBloc();
