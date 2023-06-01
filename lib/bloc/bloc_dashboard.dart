import 'dart:async';
import '../models/api/dashboard/getDashboard.dart';

class DashboardBloc{
  //-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get Dashboard
  final getDashboardStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get getDashboard_sink => getDashboardStreamController.sink;
  Stream<bool> get getDashboard_counter => getDashboardStreamController.stream;

  refreshDashboards(bool isFetched){
    getDashboard_sink.add(isFetched);
  }
}

final DashboardBloc dashboardBloc=new DashboardBloc();