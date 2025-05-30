// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/controller_report.dart';
// import 'package:post_app/models/departement_model.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../../../../models/chart_data_model.dart';

// class ChartWidget extends StatelessWidget {
//   const ChartWidget({
//     super.key,
//     required this.listDept,
//   });

//   final List<Departement> listDept;

//   @override
//   Widget build(BuildContext context) {
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SizedBox(
//           width: fullWidth < maxWidth ? 1000.w : 1000,
//           height: fullWidth < maxWidth ? 300.h : 300,
//           // padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
//           child: Consumer<ControllerReport>(
//             builder: (context, val, child) => SfCartesianChart(
//               primaryXAxis: CategoryAxis(
//                 isVisible: true,
//                 autoScrollingMode: AutoScrollingMode.start,
//                 labelRotation: 90,
//                 labelStyle:
//                     TextStyle(fontSize: fullWidth < maxWidth ? 10.sp : 10),
//                 // labelPlacement: LabelPlacement.onTicks,
//                 edgeLabelPlacement: EdgeLabelPlacement.hide,
//                 labelIntersectAction: AxisLabelIntersectAction.rotate45,
//                 majorTickLines: const MajorTickLines(size: 0),
//                 interval: 1,
//               ),
//               tooltipBehavior: TooltipBehavior(
//                 builder: (data, point, series, pointIndex, seriesIndex) {
//                   if (val.selectedDept == "") {
//                     ChartData dataIndex = data;
//                     List<String> tooltipText = [];

// // Generate tooltip text for each department
//                     for (Departement department in listDept) {
//                       String departmentName = department.departement!;

//                       // Find the data entry for the department and date
//                       ChartData entry = val.chartDataList.firstWhere(
//                         (entry) =>
//                             entry.department == departmentName &&
//                             entry.category == dataIndex.category &&
//                             entry.value != 0,
//                         orElse: () =>
//                             ChartData(departmentName, dataIndex.category, 0),
//                       );

//                       tooltipText.add('$departmentName: ${entry.value}');
//                     }

//                     return Container(
//                       padding:
//                           EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             fullWidth < maxWidth ? 15.sp : 15),
//                         color: Colors.black54,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             dataIndex.category,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: fullWidth < maxWidth ? 14.sp : 14),
//                           ),
//                           SizedBox(
//                             height: fullWidth < maxWidth ? 5.h : 5,
//                           ),
//                           Text(
//                             tooltipText.join('\n'),
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     ChartData dataIndex = data;
//                     return Container(
//                         padding:
//                             EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                               fullWidth < maxWidth ? 15.sp : 15),
//                           color: Colors.black54,
//                         ),
//                         child:
//                             Column(mainAxisSize: MainAxisSize.min, children: [
//                           Column(
//                             children: [
//                               Text(
//                                 dataIndex.category,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:
//                                         fullWidth < maxWidth ? 14.sp : 14),
//                               ),
//                               Text(
//                                 "${dataIndex.department} : ${dataIndex.value}",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:
//                                         fullWidth < maxWidth ? 14.sp : 14),
//                               ),
//                             ],
//                           )
//                         ]));
//                   }
//                 },
//                 enable: true,
//                 header: '',
//               ),
//               series: val.series,
//             ),
//           )),
//     );
//   }
// }
