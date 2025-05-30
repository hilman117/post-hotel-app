// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:post_app/Screens/create/create_request_controller.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../service/theme.dart';

// class InputLocation extends StatelessWidget {
//   final VoidCallback callback;
//   const InputLocation({super.key, required this.callback});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return InkWell(
//       onTap: callback,
//       child: Container(
//         padding:
//             EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 8.sp : 8),
//         alignment: Alignment.center,
//         width: double.infinity,
//         height: fullWidth < maxWidth ? 70.h : 90,
//         decoration: BoxDecoration(
//           color: theme.scaffoldBackgroundColor,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${AppLocalizations.of(context)!.location}:   ",
//               style: TextStyle(
//                   color: theme.focusColor,
//                   fontSize: fullWidth < maxWidth ? 15.sp : 15,
//                   fontWeight: FontWeight.normal),
//             ),
//             SizedBox(height: fullWidth < maxWidth ? 10.h : 10),
//             Consumer2<CreateRequestController, HomeController>(
//               builder: (context, value, value2, child) => Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: theme.canvasColor),
//                       borderRadius: BorderRadius.circular(
//                           fullWidth < maxWidth ? 10.r : 10)),
//                   height: fullWidth < maxWidth ? 40.h : 40,
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                             bottom: fullWidth < maxWidth ? 9.h : 9),
//                         width: fullWidth < maxWidth ? 250.w : 400,
//                         child: TypeAheadField<String>(
//                           debounceDuration: const Duration(milliseconds: 0),
//                           hideOnEmpty: true,
//                           animationStart: 0,
//                           animationDuration: const Duration(milliseconds: 0),
//                           suggestionsBoxDecoration:
//                               SuggestionsBoxDecoration(color: theme.cardColor),
//                           textFieldConfiguration: TextFieldConfiguration(
//                               cursorColor: mainColor.withOpacity(0.5),
//                               style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 15.sp : 15,
//                                   color: theme.focusColor),
//                               autofocus: false,
//                               textAlignVertical: TextAlignVertical.center,
//                               controller: value.selectedLocation,
//                               decoration: InputDecoration(
//                                   isDense: true,
//                                   hintStyle: TextStyle(
//                                       color: theme.focusColor,
//                                       fontWeight: FontWeight.normal,
//                                       fontSize:
//                                           fullWidth < maxWidth ? 15.sp : 15),
//                                   hintText: AppLocalizations.of(context)!
//                                       .typeLocation,
//                                   contentPadding: EdgeInsets.only(
//                                       top: fullWidth < maxWidth ? 11.sp : 11),
//                                   border: InputBorder.none)),
//                           suggestionsCallback: (pattern) async {
//                             print(value2.listLocation);
//                             return await value.searchLocation(
//                                 value2.listLocation, pattern);
//                           },
//                           itemBuilder: (context, suggestion) {
//                             return Container(
//                                 alignment: Alignment.centerLeft,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal:
//                                         fullWidth < maxWidth ? 10.sp : 10),
//                                 height: fullWidth < maxWidth ? 40.h : 40,
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           width: 0.5, color: Colors.grey)),
//                                 ),
//                                 child: buildHighlightedText(
//                                     context, suggestion, value.keywords));
//                           },
//                           onSuggestionSelected: (suggestion) {
//                             Provider.of<CreateRequestController>(context,
//                                     listen: false)
//                                 .selectLocation(suggestion);
//                           },
//                         ),
//                       ),
//                       const Spacer(),
//                       Image.asset(
//                         'images/location.png',
//                         width: fullWidth < maxWidth ? 19.w : 19,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildHighlightedText(BuildContext context, String text, String keyword) {
//   final theme = Theme.of(context);
//   if (keyword.isEmpty) {
//     return Text(text);
//   }

//   final List<InlineSpan> spans = [];

//   for (int i = 0; i < text.length; i++) {
//     final char = text[i];
//     final isMatch = i + keyword.length <= text.length &&
//         text.substring(i, i + keyword.length).toLowerCase() ==
//             keyword.toLowerCase();

//     spans.add(
//       TextSpan(
//         text: char,
//         style: TextStyle(
//           color: isMatch
//               ? Colors.blue
//               : theme.focusColor, // Ganti warna huruf yang cocok dengan keyword
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   return RichText(
//     text: TextSpan(children: spans),
//   );
// }
