import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/ios_view/ios_create_page.dart';
import 'package:post_app/fireabase_service/firebase_read_data.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/models/tasks.dart';
import 'package:provider/provider.dart';

import '../../../../../common_widget/status.dart';
import '../../../../dasboard/ios_dashboard.dart';
import '../../../../ios_view/ios_chatroom.dart';

class LostAndFound extends StatefulWidget {
  const LostAndFound({super.key, required this.searchText});
  final TextEditingController searchText;

  @override
  State<LostAndFound> createState() => _LostAndFoundState();
}

class _LostAndFoundState extends State<LostAndFound> {
  final ScrollController scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final eventHome = Provider.of<HomeController>(context, listen: false);
    final theme = Theme.of(context);
    final bilingual = AppLocalizations.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      // A ScrollView that creates custom scroll effects using slivers.
      child: Consumer<HomeController>(builder: (context, value, child) {
        return PopScope(
          canPop: value.canPopOut,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop && IosDashBoard.tabController.index != 0) {
              eventHome.selectScreens(0, IosDashBoard.tabController);
              eventHome.getOutFromTheApp(true);
            }
          },
          child: CustomScrollView(
            anchor: 0.05,
            controller: scroll,
            // A list of sliver widgets.
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                  alwaysShowMiddle: false,
                  middle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Lost and found",
                        style: TextStyle(
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.bold,
                            color: theme.focusColor,
                            fontSize: fullWidth < maxWidth ? 15.sp : 15),
                      ),
                    ],
                  ),
                  stretch: true,
                  largeTitle: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.sp),
                          child: CupertinoSearchTextField(
                            controller: widget.searchText,
                            style: TextStyle(
                                color: theme.focusColor,
                                fontSize: fullWidth < maxWidth ? 14.sp : 14),
                            onChanged: (value) =>
                                eventHome.getInputTextSearch(value),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lost and found",
                              style: TextStyle(
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.bold,
                                  color: theme.focusColor,
                                  fontSize: fullWidth < maxWidth ? 25.sp : 25),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: fullWidth < maxWidth ? 20.sp : 20),
                                  child: IconButton(
                                    onPressed: () {
                                      Provider.of<CreateRequestController>(
                                              context,
                                              listen: false)
                                          .clearVar();
                                      Navigator.of(context)
                                          .push(CupertinoPageRoute(
                                        builder: (context) {
                                          return const IosCreatePage(
                                            isTask: false,
                                            selectedDept: null,
                                          );
                                        },
                                      ));
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.add_circled,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              // This widget fills the remaining space in the viewport.
              // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
              SliverFillRemaining(
                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseReadData().getLostAndFountByName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Platform.isIOS
                          ? const CircularProgressIndicator.adaptive()
                          : const CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<TaskModel> listLF = snapshot.data!.docs
                        .map((e) => TaskModel.fromJson(e.data()))
                        .toList();
                    listLF.sort(
                      (a, b) => b.time!.compareTo(a.time!),
                    );
                    return Consumer<HomeController>(
                        builder: (context, value, child) {
                      return Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Wrap(
                            spacing: 10.sp,
                            runSpacing: 10.sp,
                            alignment: WrapAlignment.start, // pastikan ini
                            runAlignment: WrapAlignment.spaceEvenly,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: List.generate(
                              listLF.length,
                              (index) {
                                TaskModel lf = listLF[index];
                                if (lf.title!.toLowerCase().contains(
                                        value.textInput.toLowerCase()) ||
                                    lf.location!.toLowerCase().contains(
                                        value.textInput.toLowerCase()) ||
                                    lf.sender!.toLowerCase().contains(
                                        value.textInput.toLowerCase()) ||
                                    value.textInput.isEmpty) {
                                  return Material(
                                    color: Colors.white,
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              16, // 2 items per row
                                      color: Colors.grey.shade100,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.network(
                                                lf.image!.first,
                                                width: 150.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Image.asset(
                                                    width: 150.w,
                                                    height: 150.h,
                                                    "images/load_image.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 5.h),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        if (lf.isValueable!)
                                                          Icon(
                                                            CupertinoIcons
                                                                .suit_diamond_fill,
                                                            color: CupertinoColors
                                                                .systemOrange,
                                                          ),
                                                        if (lf.isValueable!)
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                        Expanded(
                                                          child: Text(lf.title!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_pin,
                                                          color: Colors.grey,
                                                          size: 20.sp,
                                                        ),
                                                        // SizedBox(
                                                        //   width: 5.w,
                                                        // ),
                                                        Text(lf.location!,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.access_time,
                                                          color: Colors.grey,
                                                          size: 20.sp,
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  "MMMM dd, yyyy")
                                                              .format(lf.time!
                                                                  .toDate()
                                                                  .toLocal())
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  fullWidth <
                                                                          maxWidth
                                                                      ? 16.sp
                                                                      : 16,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    SizedBox(
                                                      height: 25.h,
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                CupertinoPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            IosChatRoom(
                                                                              taskModel: lf,
                                                                              isTask: false,
                                                                              isWithKeyboard: true,
                                                                            )));
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                          child: Text(
                                                            bilingual!
                                                                .viewDetails,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Positioned(
                                              right: 5.w,
                                              top: 5.h,
                                              child: StatusWidget(
                                                fontSize: 16.sp,
                                                status: lf.status!,
                                                height: 25.h,
                                                isFading: lf.isFading!,
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                  //   return Card(
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(16.r)),
                                  //       child: CupertinoListTile(
                                  //         backgroundColor: theme.cardColor,
                                  //         onTap: () {
                                  //           Navigator.of(context).push(CupertinoPageRoute(
                                  //               builder: (context) => IosChatRoom(
                                  //                     taskModel: lf,
                                  //                     isTask: false,
                                  //                     isWithKeyboard: true,
                                  //                   )));
                                  //         },
                                  //         padding: const EdgeInsets.all(0),
                                  //         title: Row(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             Row(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Container(
                                  //                     decoration: BoxDecoration(
                                  //                         borderRadius:
                                  //                             BorderRadius.circular(10.r)),
                                  //                     margin: EdgeInsets.all(8.sp),
                                  //                     width:
                                  //                         fullWidth < maxWidth ? 70.w : 70,
                                  //                     height:
                                  //                         fullWidth < maxWidth ? 70.h : 70,
                                  //                     child: Image.network(
                                  //                       lf.image!.first,
                                  //                       fit: BoxFit.fill,
                                  //                       loadingBuilder: (context, child,
                                  //                           loadingProgress) {
                                  //                         if (loadingProgress == null) {
                                  //                           return child;
                                  //                         }
                                  //                         return Image.asset(
                                  //                           "images/load_image.png",
                                  //                           fit: BoxFit.fill,
                                  //                         );
                                  //                       },
                                  //                     )),
                                  //                 Padding(
                                  //                   padding: EdgeInsets.only(top: 8.sp),
                                  //                   child: Column(
                                  //                     crossAxisAlignment:
                                  //                         CrossAxisAlignment.start,
                                  //                     children: [
                                  //                       SizedBox(
                                  //                         width: 170.w,
                                  //                         child: Text(
                                  //                           lf.title!,
                                  //                           style: TextStyle(
                                  //                               fontSize:
                                  //                                   fullWidth < maxWidth
                                  //                                       ? 16.sp
                                  //                                       : 16,
                                  //                               color: theme.focusColor,
                                  //                               fontWeight:
                                  //                                   FontWeight.bold),
                                  //                         ),
                                  //                       ),
                                  //                       SizedBox(
                                  //                         width: 170.w,
                                  //                         child: Text(
                                  //                           lf.location!,
                                  //                           style: TextStyle(
                                  //                               fontSize:
                                  //                                   fullWidth < maxWidth
                                  //                                       ? 14.sp
                                  //                                       : 14,
                                  //                               color: theme.focusColor,
                                  //                               fontWeight:
                                  //                                   FontWeight.normal),
                                  //                         ),
                                  //                       ),
                                  //                       SizedBox(
                                  //                         width: 170.w,
                                  //                         child: Text(
                                  //                           lf.sender!,
                                  //                           style: TextStyle(
                                  //                               fontSize:
                                  //                                   fullWidth < maxWidth
                                  //                                       ? 14.sp
                                  //                                       : 14,
                                  //                               color: theme.focusColor,
                                  //                               fontWeight:
                                  //                                   FontWeight.normal),
                                  //                         ),
                                  //                       ),
                                  //                       if (lf.description!.isNotEmpty)
                                  //                         SizedBox(
                                  //                           width: 170.w,
                                  //                           child: Text(
                                  //                             lf.description!,
                                  //                             style: TextStyle(
                                  //                                 fontSize:
                                  //                                     fullWidth < maxWidth
                                  //                                         ? 14.sp
                                  //                                         : 14,
                                  //                                 color: theme.focusColor,
                                  //                                 fontWeight:
                                  //                                     FontWeight.normal),
                                  //                             overflow:
                                  //                                 TextOverflow.ellipsis,
                                  //                           ),
                                  //                         ),
                                  //                       Text(
                                  //                         DateFormat("HH:mm dd/MM/yy")
                                  //                             .format(lf.time!
                                  //                                 .toDate()
                                  //                                 .toLocal())
                                  //                             .toString(),
                                  //                         style: TextStyle(
                                  //                             fontSize: fullWidth < maxWidth
                                  //                                 ? 14.sp
                                  //                                 : 14,
                                  //                             color: theme.focusColor,
                                  //                             fontWeight:
                                  //                                 FontWeight.normal),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //             Padding(
                                  //               padding: EdgeInsets.all(8.0.sp),
                                  //               child: SizedBox(
                                  //                 width: 80.w,
                                  //                 child: StatusWidget(
                                  //                     status: lf.status!,
                                  //                     isFading: lf.isFading!,
                                  //                     height: 30.h,
                                  //                     fontSize: fullWidth < maxWidth
                                  //                         ? 14.sp
                                  //                         : 14),
                                  //               ),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ));
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      );
                    });
                  }
                  return const Center();
                },
              )),
            ],
          ),
        );
      }),
    );
  }
}

// Widget _buildShimmerList() {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey[300]!,
//     highlightColor: Colors.grey[100]!,
//     child: ListView.builder(
//       itemCount: 5, // You can adjust the number of shimmer items
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Container(
//             height: 20.0,
//             color: Colors.white, // Color of the shimmer
//           ),
//           // Add more shimmer placeholders for other parts of your list item
//         );
//       },
//     ),
//   );
// }
