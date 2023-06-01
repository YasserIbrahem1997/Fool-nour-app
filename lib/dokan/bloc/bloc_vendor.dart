// import 'dart:async';
// import 'package:ecom/dokan/models/api/vendor/getAllWcfmVendorsResponceModel.dart';
//
// class VendorBloc{
//   //-------------------------------------- HTTP REQUESTS -------------------------------------//
//   //get Vendors
//   final getVendorStreamController = StreamController<List<GetAllDokanVendors>>.broadcast();
//   StreamSink<List<GetAllDokanVendors>> get getVendor_sink => getVendorStreamController.sink;
//   Stream<List<GetAllDokanVendors>> get getVendor_counter => getVendorStreamController.stream;
//
//   refreshVendors(List<GetAllDokanVendors> Vendors){
//     getVendor_sink.add(Vendors);
//   }
// }
//
// final VendorBloc vendorBloc=new VendorBloc();