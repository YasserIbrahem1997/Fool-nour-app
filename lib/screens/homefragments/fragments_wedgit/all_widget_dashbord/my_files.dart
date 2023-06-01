import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/get_order_cubit.dart';
import '../../../../cubit/get_ordere_statrs.dart';
import '../../../../models/api/order/getOrders.dart';
import '../../../../respons.dart';
import '../dashbord_screen.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                " حالات الطلبات",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New Admin"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
   FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
   List<GetOrderResponce> getDataOrdereModel = [];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width / 1.05,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: BlocConsumer<GetAllOrderCubit, GetAllOrderStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AuthInitialztionStates ||
                          state is GetAllOrderStatesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetAllOrderStatesSuccess) {
                        final cubitsData = state.DataOrdere;
                        return Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(defaultPadding * 0.75),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    // child: SvgPicture.asset(
                                    //   info.svgSrc!,
                                    //   color: info.color,
                                    // ),
                                  ),
                                  // Icon(Icons.more_vert, color: Colors.white54)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "جميع الطلبات",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    cubitsData.length.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.white),
                                  ),

                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          state.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    /*
                           StreamBuilder(
                            stream: orderBloc.getOrderStreamController.stream,
                            initialData: AllOrders,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(getAllOrderCubit.tempListResponce.length.toString());


                                /*
                                (snapshot.data != null)
                                  ? Column(
                                  children:List<GetOrderResponce>.from(snapshot.data)
                                      .map((data) => _item(data))
                                      .toList()
                                  )
                                  : Container(
                                child: JumpingDotsProgressIndicator(
                                  fontSize: 30.0,
                                  color: MainHighlighter,
                                ),
                              );

                                 */
                            },
                          )


                           */

                    // SingleChildScrollView(
                    //   padding: EdgeInsets.all(defaultPadding),
                    //   child: Column(
                    //     children: [
                    //       // Header(),
                    //       SizedBox(height: defaultPadding),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             flex: 5,
                    //             child: Column(
                    //               children: [
                    //                 MyFiles(),
                    //                 SizedBox(height: defaultPadding),
                    //                 RecentFiles(),
                    //                 if (Responsive.isMobile(context))
                    //                   SizedBox(height: defaultPadding),
                    //                 // if (Responsive.isMobile(context)) StarageDetails(),
                    //               ],
                    //             ),
                    //           ),
                    //           if (!Responsive.isMobile(context))
                    //             SizedBox(width: defaultPadding),
                    //           // On Mobile means if the screen is less than 850 we dont want to show it
                    //           // if (!Responsive.isMobile(context))
                    //           //   Expanded(
                    //           //     flex: 2,
                    //           //     child: StarageDetails(),
                    //           //   ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: BlocConsumer<GetAllOrderCubit, GetAllOrderStates>(

                    listener: (context, state) {},
                    builder: (context, state) {
                      var getDiscountData =
                      BlocProvider.of<GetAllOrderCubit>(context, listen: true);
                      if (state is AuthInitialztionStates ||
                          state is GetAllOrderStatesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetAllOrderStatesSuccess) {
                        final cubitsData = state.DataOrdere;
                        return Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(defaultPadding * 0.75),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    // child: SvgPicture.asset(
                                    //   info.svgSrc!,
                                    //   color: info.color,
                                    // ),
                                  ),
                                  // Icon(Icons.more_vert, color: Colors.white54)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubitsData.length.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.white),
                                  ),
                                  // Text(
                                  //   cubitsData[index].total,
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .caption!
                                  //       .copyWith(color: Colors.white),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          state.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    /*
                           StreamBuilder(
                            stream: orderBloc.getOrderStreamController.stream,
                            initialData: AllOrders,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(getAllOrderCubit.tempListResponce.length.toString());


                                /*
                                (snapshot.data != null)
                                  ? Column(
                                  children:List<GetOrderResponce>.from(snapshot.data)
                                      .map((data) => _item(data))
                                      .toList()
                                  )
                                  : Container(
                                child: JumpingDotsProgressIndicator(
                                  fontSize: 30.0,
                                  color: MainHighlighter,
                                ),
                              );

                                 */
                            },
                          )


                           */

                    // SingleChildScrollView(
                    //   padding: EdgeInsets.all(defaultPadding),
                    //   child: Column(
                    //     children: [
                    //       // Header(),
                    //       SizedBox(height: defaultPadding),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             flex: 5,
                    //             child: Column(
                    //               children: [
                    //                 MyFiles(),
                    //                 SizedBox(height: defaultPadding),
                    //                 RecentFiles(),
                    //                 if (Responsive.isMobile(context))
                    //                   SizedBox(height: defaultPadding),
                    //                 // if (Responsive.isMobile(context)) StarageDetails(),
                    //               ],
                    //             ),
                    //           ),
                    //           if (!Responsive.isMobile(context))
                    //             SizedBox(width: defaultPadding),
                    //           // On Mobile means if the screen is less than 850 we dont want to show it
                    //           // if (!Responsive.isMobile(context))
                    //           //   Expanded(
                    //           //     flex: 2,
                    //           //     child: StarageDetails(),
                    //           //   ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width / 1.05,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            children: [

              Expanded(
                flex: 5,
                child: BlocConsumer<GetAllOrderCubit, GetAllOrderStates>(

                    listener: (context, state) {},
                    builder: (context, state) {
                      var getDiscountData =
                      BlocProvider.of<GetAllOrderCubit>(context, listen: true);
                      if (state is AuthInitialztionStates ||
                          state is GetAllOrderStatesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetAllOrderStatesSuccess) {
                        final cubitsData = state.DataOrdere;
                       return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                        EdgeInsets.all(defaultPadding * 0.75),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        // child: SvgPicture.asset(
                                        //   info.svgSrc!,
                                        //   color: info.color,
                                        // ),
                                      ),
                                      // Icon(Icons.more_vert, color: Colors.white54)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                  cubitsData[index].status =="processing"?  cubitsData[index].status.length.toString():"e",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: Colors.white),
                                      ),
                                      // Text(
                                      //   cubitsData[index].total,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .caption!
                                      //       .copyWith(color: Colors.white),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },

                        );
                      }
                      return Center(
                        child: Text(
                          state.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    /*
                           StreamBuilder(
                            stream: orderBloc.getOrderStreamController.stream,
                            initialData: AllOrders,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(getAllOrderCubit.tempListResponce.length.toString());


                                /*
                                (snapshot.data != null)
                                  ? Column(
                                  children:List<GetOrderResponce>.from(snapshot.data)
                                      .map((data) => _item(data))
                                      .toList()
                                  )
                                  : Container(
                                child: JumpingDotsProgressIndicator(
                                  fontSize: 30.0,
                                  color: MainHighlighter,
                                ),
                              );

                                 */
                            },
                          )


                           */

                    // SingleChildScrollView(
                    //   padding: EdgeInsets.all(defaultPadding),
                    //   child: Column(
                    //     children: [
                    //       // Header(),
                    //       SizedBox(height: defaultPadding),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             flex: 5,
                    //             child: Column(
                    //               children: [
                    //                 MyFiles(),
                    //                 SizedBox(height: defaultPadding),
                    //                 RecentFiles(),
                    //                 if (Responsive.isMobile(context))
                    //                   SizedBox(height: defaultPadding),
                    //                 // if (Responsive.isMobile(context)) StarageDetails(),
                    //               ],
                    //             ),
                    //           ),
                    //           if (!Responsive.isMobile(context))
                    //             SizedBox(width: defaultPadding),
                    //           // On Mobile means if the screen is less than 850 we dont want to show it
                    //           // if (!Responsive.isMobile(context))
                    //           //   Expanded(
                    //           //     flex: 2,
                    //           //     child: StarageDetails(),
                    //           //   ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "جميع الاوردارات",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "2",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "اكتمل التوصيل",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "0",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "جاري التوصيل",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "0",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "تم الاستلام",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "2",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
