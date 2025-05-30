// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:post_app/Screens/create/create_request_controller.dart';
// import 'package:provider/provider.dart';

// import 'tile_title.dart';

// void titleList(BuildContext context, String tasksId, String emailSender,
//     List<String> titleList) {
//   final theme = Theme.of(context);
//   double fullWidth = MediaQuery.of(context).size.width;
//   double maxWidth = 500;
//   showAnimatedDialog(
//       alignment: Alignment.bottomCenter,
//       barrierDismissible: true,
//       duration: const Duration(milliseconds: 500),
//       animationType: DialogTransitionType.slideFromRight,
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//             builder: (context, setState) => Padding(
//                   padding:
//                       EdgeInsets.only(top: fullWidth < maxWidth ? 25.sp : 25),
//                   child: Center(
//                     child: SingleChildScrollView(
//                       child: AlertDialog(
//                         shadowColor: theme.canvasColor,
//                         backgroundColor: theme.scaffoldBackgroundColor,
//                         contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 fullWidth < maxWidth ? 10.sp : 10)),
//                         content: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     fullWidth < maxWidth ? 10.sp : 10),
//                                 color: theme.scaffoldBackgroundColor),
//                             // height: 500,
//                             width: fullWidth < maxWidth ? 500.w : 500,
//                             child: Consumer<CreateRequestController>(
//                               builder: (context, value, child) => Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SizedBox(
//                                     height: fullWidth < maxWidth ? 15.h : 15,
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(
//                                           fullWidth < maxWidth ? 50.sp : 50),
//                                       onTap: () {},
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             right: fullWidth < maxWidth
//                                                 ? 10.w
//                                                 : 10),
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           height:
//                                               fullWidth < maxWidth ? 30.h : 30,
//                                           width:
//                                               fullWidth < maxWidth ? 30.w : 30,
//                                           decoration: const BoxDecoration(
//                                               shape: BoxShape.circle),
//                                           child: CloseButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Text(
//                                       "Predefined Request",
//                                       style: TextStyle(
//                                           fontSize:
//                                               fullWidth < maxWidth ? 16.sp : 16,
//                                           color: theme.focusColor),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: fullWidth < maxWidth ? 15.h : 15,
//                                   ),
//                                   SizedBox(
//                                     height: fullWidth < maxWidth ? 45.h : 45,
//                                     width: double.infinity,
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal:
//                                               fullWidth < maxWidth ? 20.w : 20),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: fullWidth < maxWidth
//                                                     ? 5.h
//                                                     : 5),
//                                             child: Icon(
//                                               Icons.search,
//                                               color: Colors.blue,
//                                               size: fullWidth < maxWidth
//                                                   ? 20.sp
//                                                   : 20,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width:
//                                                 fullWidth < maxWidth ? 5.w : 5,
//                                           ),
//                                           Expanded(
//                                             child: TextFormField(
//                                               decoration: InputDecoration(
//                                                   hintText: "Search",
//                                                   hintStyle: TextStyle(
//                                                       fontSize:
//                                                           fullWidth < maxWidth
//                                                               ? 14.sp
//                                                               : 14,
//                                                       color: theme.focusColor,
//                                                       fontStyle:
//                                                           FontStyle.italic)),
//                                               controller: value.searchtitle,
//                                               onChanged: (value) {
//                                                 Provider.of<CreateRequestController>(
//                                                         context,
//                                                         listen: false)
//                                                     .setstate(value);
//                                               },
//                                               autofocus: false,
//                                             ),
//                                           ),
//                                           value.searchTitle.isEmpty
//                                               ? Container()
//                                               : CloseButton(
//                                                   color: Colors.grey,
//                                                   onPressed: () {
//                                                     Provider.of<CreateRequestController>(
//                                                             context,
//                                                             listen: false)
//                                                         .clearSearchTitle();
//                                                   },
//                                                 )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: fullWidth < maxWidth ? 10.h : 10,
//                                   ),
//                                   LimitedBox(
//                                     maxHeight:
//                                         fullWidth < maxWidth ? 500.h : 500,
//                                     child: ListView.builder(
//                                         shrinkWrap: true,
//                                         itemCount: titleList.length,
//                                         itemBuilder: (context, index) {
//                                           print(titleList[index]);
//                                           List.generate(
//                                               titleList.length,
//                                               (index) => titleTile(
//                                                   context,
//                                                   index,
//                                                   titleList[index],
//                                                   tasksId,
//                                                   emailSender));
//                                           if (value.searchTitle.isEmpty) {
//                                             return titleTile(
//                                                 context,
//                                                 index,
//                                                 titleList[index],
//                                                 tasksId,
//                                                 emailSender);
//                                           }
//                                           if (titleList[index]
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains(value.searchTitle
//                                                   .toLowerCase())) {
//                                             return titleTile(
//                                                 context,
//                                                 index,
//                                                 titleList[index],
//                                                 tasksId,
//                                                 emailSender);
//                                           }
//                                           return Container();
//                                         }),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ));
//       });
// }
