// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:post_app/Screens/create/create_request_controller.dart';
// import 'package:provider/provider.dart';

// Future<void> listLoaction(BuildContext context, String tasksId,
//     String emailSender, String oldLocation) async {
//   showAnimatedDialog(
//       alignment: Alignment.bottomCenter,
//       barrierDismissible: true,
//       duration: const Duration(milliseconds: 500),
//       animationType: DialogTransitionType.slideFromRight,
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//             builder: (context, setState) => Padding(
//                   padding: const EdgeInsets.only(top: 25),
//                   child: Center(
//                     child: SingleChildScrollView(
//                       child: AlertDialog(
//                         contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         content: SizedBox(
//                           // height: 500,
//                           width: 500,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(50),
//                                   onTap: () {},
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 10),
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       height: 30,
//                                       width: 30,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle),
//                                       child: CloseButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const Center(
//                                 child: Text(
//                                   "List of location",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               SizedBox(
//                                 height: 45,
//                                 width: double.infinity,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20),
//                                   child: Row(
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(top: 5),
//                                         child: Icon(
//                                           Icons.search,
//                                           color: Colors.blue,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Expanded(
//                                         child: TextFormField(
//                                           controller: Provider.of<
//                                                       CreateRequestController>(
//                                                   context,
//                                                   listen: false)
//                                               .searchtitle,
//                                           onChanged: (value) {
//                                             Provider.of<CreateRequestController>(
//                                                     context,
//                                                     listen: false)
//                                                 .setstate(value);
//                                           },
//                                           autofocus: false,
//                                         ),
//                                       ),
//                                       Provider.of<CreateRequestController>(
//                                                   context)
//                                               .searchTitle
//                                               .isEmpty
//                                           ? Container()
//                                           : CloseButton(
//                                               color: Colors.grey,
//                                               onPressed: () {
//                                                 Provider.of<CreateRequestController>(
//                                                         context,
//                                                         listen: false)
//                                                     .clearSearchTitle();
//                                               },
//                                             )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               // LimitedBox(
//                               //   maxHeight: 500,
//                               //   child: Container(
//                               //     child: ListView.builder(
//                               //         shrinkWrap: true,
//                               //         itemCount:
//                               //             Provider.of<CreateRequestController>(
//                               //                     context)
//                               //                 .data
//                               //                 .length,
//                               //         itemBuilder: (context, index) {
//                               //           print(Provider.of<
//                               //                       CreateRequestController>(
//                               //                   context)
//                               //               .data[index]);
//                               //           List.generate(
//                               //               Provider.of<CreateRequestController>(
//                               //                       context)
//                               //                   .data
//                               //                   .length,
//                               //               (index) => locationCard(context,
//                               //                   index, tasksId, emailSender, oldLocation));
//                               //           if (Provider.of<
//                               //                       CreateRequestController>(
//                               //                   context)
//                               //               .searchTitle
//                               //               .isEmpty) {
//                               //             return locationCard(context, index,
//                               //                 tasksId, emailSender, oldLocation);
//                               //           }
//                               //           if (Provider.of<
//                               //                       CreateRequestController>(
//                               //                   context)
//                               //               .data[index]
//                               //               .toString()
//                               //               .toLowerCase()
//                               //               .contains(Provider.of<
//                               //                           CreateRequestController>(
//                               //                       context)
//                               //                   .searchTitle
//                               //                   .toLowerCase())) {
//                               //             return locationCard(context, index,
//                               //                 tasksId, emailSender, oldLocation);
//                               //           }
//                               //           return Container();
//                               //         }),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ));
//       });
// }
