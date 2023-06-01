// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// class CircularScrollView extends StatefulWidget {
//   final List<Widget> items;
//   final double radius;
//   final double itemMaxHeight;
//   final double itemMaxWidth;
//   final double padding;
//   final bool reverse;
//   CircularScrollView(this.items, {Key key, this.radius=10, this.itemMaxHeight=0, this.itemMaxWidth=0, this.padding=0, this.reverse=false}) : super(key: key);
//   @override
//   _CircularScrollViewState createState() => _CircularScrollViewState();
// }
//
// class _CircularScrollViewState extends State<CircularScrollView> {
//   double lastPosition;
//   List<Widget> transformItems= [];
//   double degreesRotated = 0;
//
//   @override
//   void initState() {
//     setState(() {
//       _calculateTransformItems();
//     });
//     super.initState();
//   }
//   void _calculateTransformItems(){
//     transformItems= [];
//     for(int i = 0; i<widget.items.length; i++){
//       double startAngle = (i/widget.items.length)*2*math.pi;
//       double currentAngle = degreesRotated+startAngle;
//       transformItems.add(
//         Transform(
//           transform: Matrix4.identity()..translate(
//             (widget.radius)*math.cos(currentAngle),
//             (widget.radius)*math.sin(currentAngle),
//           ),
//           child: widget.items[i],
//         ),
//       );
//     }
//   }
//   void _calculateScroll(DragUpdateDetails details){
//     if (lastPosition == null){
//       lastPosition = details.localPosition.dy;
//       return;
//     }
//     double distance = details.localPosition.dy - lastPosition;
//     double distanceWithReversal = widget.reverse?-distance:distance;
//     lastPosition =details.localPosition.dy;
//     degreesRotated += distanceWithReversal/(widget.radius);
//     _calculateTransformItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         height: widget.radius*2+widget.itemMaxHeight,
//         width: widget.radius*2 + widget.itemMaxWidth,
//         child: GestureDetector(
//           onVerticalDragUpdate: (details)=>setState((){_calculateScroll(details);}),
//           onVerticalDragEnd: (details){lastPosition=null;},
//           child: Container(
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.transparent,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: widget.padding),
//                   child: Stack(
//                     children: transformItems,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }