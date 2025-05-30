// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/controller_report.dart';
// import 'package:post_app/common_widget/loading.dart';
// import 'package:post_app/common_widget/show_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';

// customCalendar(BuildContext context) {
//   double fullWidth = MediaQuery.of(context).size.width;
//   double maxWidth = 500;
//   return showDialog(
//     barrierColor: Colors.black54,
//     barrierDismissible: true,
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//           alignment: Alignment.centerRight,
//           shape: RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(fullWidth < maxWidth ? 20.sp : 20),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child: const MyCalendar());
//     },
//   );
// }

// class MyCalendar extends StatefulWidget {
//   const MyCalendar({Key? key}) : super(key: key);

//   @override
//   State<MyCalendar> createState() => _MyCalendarState();
// }

// class _MyCalendarState extends State<MyCalendar> {
//   @override
//   Widget build(BuildContext context) {
//     // final value = context.watch<ReportController>();
//     final event = Provider.of<ControllerReport>(context, listen: false);
//     final eventAdmin = Provider.of<AdminController>(context, listen: false);
//     final theme = Theme.of(context);
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return Consumer3<ControllerReport, HomeController, AdminController>(
//       builder: (context, value, value2, value3, child) => FittedBox(
//         child: Container(
//           decoration: BoxDecoration(
//               color: theme.cardColor,
//               borderRadius: BorderRadius.circular(20.0),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 2.0,
//                     offset: Offset(0.0, 0.5))
//               ]),
//           // height: 350,
//           width: fullWidth < maxWidth ? 300.sp : 350,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TableCalendar(
//                 rowHeight: fullWidth < maxWidth ? 30.sp : 30,
//                 headerStyle: HeaderStyle(
//                     leftChevronIcon: Icon(
//                       Icons.chevron_left,
//                       color: theme.primaryColor,
//                     ),
//                     rightChevronIcon: Icon(
//                       Icons.chevron_right,
//                       color: theme.primaryColor,
//                     ),
//                     titleTextStyle: TextStyle(
//                         fontWeight: FontWeight.normal, color: theme.focusColor),
//                     headerPadding: const EdgeInsets.all(0),
//                     formatButtonVisible: false,
//                     titleCentered: true),
//                 calendarStyle: const CalendarStyle(
//                   todayDecoration: BoxDecoration(shape: BoxShape.rectangle),
//                   outsideTextStyle: TextStyle(
//                       fontWeight: FontWeight.normal, color: Colors.black54),
//                   weekNumberTextStyle: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.grey),
//                   weekendTextStyle: TextStyle(
//                       fontWeight: FontWeight.normal, color: Colors.black),
//                   defaultTextStyle: TextStyle(
//                       fontWeight: FontWeight.normal, color: Colors.black),
//                   cellMargin: EdgeInsets.all(0),
//                   markerMargin: EdgeInsets.all(0),
//                 ),
//                 firstDay: DateTime(2021, 03, 28),
//                 lastDay: DateTime(DateTime.now().year + 5, 03, 28),
//                 focusedDay: value.focusedDay,
//                 selectedDayPredicate: (day) =>
//                     isSameDay(value.selectedDay, day),
//                 rangeStartDay: value.rangeStart,
//                 rangeEndDay: value.rangeEnd,
//                 calendarFormat: value.calendarFormat,
//                 rangeSelectionMode: value.rangeSelectionMode,
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(value.selectedDay, selectedDay)) {
//                     event.onDaySelected(selectedDay, focusedDay);
//                   }
//                 },
//                 onRangeSelected: (start, end, focusedDay) {
//                   event.onRangeSelected(focusedDay, start, end);
//                 },
//                 onFormatChanged: (format) {
//                   if (value.calendarFormat != format) {
//                     event.onFormatChanged(format);
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   value.focusedDay = focusedDay;
//                 },
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 30.h : 30,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: fullWidth < maxWidth ? 30.w : 30,
//                     vertical: fullWidth < maxWidth ? 10.h : 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 30.h : 30,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey.shade300),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text(
//                             "cancel",
//                             style: GoogleFonts.mPlusRounded1c(
//                                 fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                                 color: theme.primaryColor),
//                           )),
//                     ),
//                     SizedBox(
//                       width: fullWidth < maxWidth ? 20.w : 20,
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 30.h : 30,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: theme.primaryColor),
//                           onPressed: () async {
//                             if (value.rangeStart == null ||
//                                 value.rangeEnd == null) {
//                               ShowDialog().alerDialog(
//                                   context, "Should choose 2 range date");
//                             } else {
//                               loading(context);
//                               var listDepartement = value2.listDepartement
//                                   .where((element) => element.isActive == true)
//                                   .toList();
//                               await event.getAllTaskData(context);
//                               await event.getPreviousMonthDates();
//                               await event.calculateUserProductivity(
//                                   value3.listEmployee);
//                               await eventAdmin.getEmployeeData(context);
//                               await event
//                                   .getMost10CreatorRequest(value3.listEmployee);
//                               await event.getPopularTitle(listDepartement);
//                               await event.getPopularLocation(value2.dataHotel!);
//                               await event.getTopReceiver(value3.listEmployee);
//                               event.getChartSeries(listDepartement);
//                               Navigator.of(context).pop();
//                             }
//                             Navigator.of(context).pop();
//                           },
//                           child: Text(
//                             "Apply",
//                             style: GoogleFonts.mPlusRounded1c(
//                                 fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                                 color: Colors.white),
//                           )),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
