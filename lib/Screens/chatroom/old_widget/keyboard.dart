// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:post/Screens/sign_up/signup.dart';
// import 'package:post/controller/c_user.dart';
// import 'package:post/Screens/example/general_widget.dart';
// import 'package:post/service/notif.dart';
// import 'package:uuid/uuid.dart';

// class Keyboard2 extends StatefulWidget {
//   const Keyboard2({
//     Key? key,
//     required this.taskId,
//     required this.hotel,
//     required this.dept,
//     required this.scroll,
//     required this.from,
//     required this.status,
//     required this.receiver,
//     required this.emailSender,
//     required this.location,
//     required this.title,
//     required this.sendTo,
//   }) : super(key: key);

//   final String taskId;
//   final String hotel;
//   final String emailSender;
//   final String dept;
//   final String from;
//   final String sendTo;
//   final String status;
//   final String receiver;
//   final String location;
//   final String title;
//   final ScrollController scroll;

//   @override
//   State<Keyboard2> createState() => _Keyboard2State();
// }

// class _Keyboard2State extends State<Keyboard2> {
//   TextEditingController searchController = TextEditingController();

//   Future assign(BuildContext context) {
//     // ignore: unused_local_variable
//     bool choose = false;
//     return showAnimatedDialog(
//         animationType: DialogTransitionType.slideFromRight,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(
//               builder: (context, setState) => Center(
//                     child: SingleChildScrollView(
//                       child: Dialog(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16)),
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 2000),
//                             // height: 500,
//                             // width: 300,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(16)),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 25),
//                                   Text("Assign To:",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.blue.shade900)),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         color: Colors.blue.shade50,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Radio<int>(
//                                                   activeColor: Colors.grey,
//                                                   value: 0,
//                                                   groupValue: _radioValue,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       _radioValue = 0;
//                                                       iGroup = true;
//                                                     });
//                                                   }),
//                                               Text(
//                                                 "Grup",
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 50,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Radio<int>(
//                                                 activeColor: Colors.grey,
//                                                 value: 1,
//                                                 groupValue: _radioValue,
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _radioValue = 1;
//                                                     iGroup = false;
//                                                   });
//                                                 },
//                                               ),
//                                               Text(
//                                                 "Users",
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.search,
//                                         color: Colors.grey.shade400,
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           height: 35,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 5),
//                                             child: TextFormField(
//                                               style:
//                                                   TextStyle(color: Colors.grey),
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   textInput = value;
//                                                 });
//                                               },
//                                               controller: searchController,
//                                               textAlignVertical:
//                                                   TextAlignVertical.top,
//                                               decoration: InputDecoration(
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey,
//                                                       fontStyle:
//                                                           FontStyle.italic),
//                                                   hintText: "Search",
//                                                   contentPadding:
//                                                       EdgeInsets.only(
//                                                           bottom: 15)),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   AnimatedSwitcher(
//                                       duration: Duration(milliseconds: 500),
//                                       child: iGroup
//                                           ? LimitedBox(
//                                               maxHeight: 300,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.blue.shade50,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             16)),
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount:
//                                                         departments.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       if (textInput.isEmpty) {
//                                                         return listOfGroup(
//                                                             departments[index]);
//                                                       }
//                                                       if (departments[index]
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(textInput
//                                                               .toLowerCase())) {
//                                                         return listOfGroup(
//                                                             departments[index]);
//                                                       }
//                                                       return SizedBox();
//                                                     }),
//                                               ),
//                                             )
//                                           : LimitedBox(
//                                               maxHeight: 300,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.blue.shade50,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             16)),
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount: names.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       if (textInput.isEmpty) {
//                                                         return listOfEmployee(
//                                                             names[index],
//                                                             emailList[index]);
//                                                       }
//                                                       if (names[index]
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(textInput
//                                                               .toLowerCase())) {
//                                                         return listOfEmployee(
//                                                             names[index],
//                                                             emailList[index]);
//                                                       }
//                                                       return SizedBox(
//                                                         height: 0,
//                                                       );
//                                                     }),
//                                               ),
//                                             )),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(vertical: 5),
//                                     child: Container(
//                                       height: 30,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           GeneralButton(
//                                             buttonName: "Cancel",
//                                             height: 25,
//                                             primary: Colors.white,
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             colorText: Colors.blue,
//                                             widht: 100,
//                                           ),
//                                           GeneralButton(
//                                             buttonName: "Assign",
//                                             height: 25,
//                                             primary: Color(0xff007dff),
//                                             onPressed: () {
//                                               if (isSwitched != true) {
//                                                 Fluttertoast.showToast(
//                                                     msg:
//                                                         "Please Select Receiver",
//                                                     backgroundColor:
//                                                         Colors.white,
//                                                     textColor: Colors.black);
//                                               } else {
//                                                 assignTask();
//                                               }
//                                             },
//                                             colorText: Colors.white,
//                                             widht: 100,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )),
//                     ),
//                   ));
//         });
//   }

//   getDeptartement() async {
//     var result = await FirebaseFirestore.instance
//         .collection("users")
//         .where("hotelid", isEqualTo: cUser.data.hotelid)
//         .get();
//     Set listDepartement =
//         result.docs.map((e) => e.data()['department']).toSet();
//     List<String> list = List.castFrom(listDepartement.toList());
//     departments.addAll(list);
//     print(listDepartement);
//     setState(() {});
//   }

//   getNames() async {
//     var result = await FirebaseFirestore.instance
//         .collection("users")
//         .where("hotelid", isEqualTo: cUser.data.hotelid)
//         .get();
//     Set listName = result.docs.map((e) => e.data()['name']).toSet();
//     Set listemail = result.docs.map((e) => e.data()['email']).toSet();
//     print(listemail);
//     print(listName);
//     List<String> list = List.castFrom(listName.toList());
//     List<String> listEmail = List.castFrom(listemail.toList());
//     names.addAll(list);
//     emailList.addAll(listEmail);
//     setState(() {});
//   }

//   List<String> departments = [];
//   String selected = '';
//   String selectedEmail = '';
//   List<String> names = [];
//   List<String> emailList = [];
//   int _radioValue = 0;
//   bool iGroup = true;
//   Widget radioButton() {
//     return StatefulBuilder(
//       builder: (context, setState) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Container(
//           width: double.infinity,
//           height: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.grey.shade200,
//           ),
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   Radio<int>(
//                       value: 0,
//                       groupValue: _radioValue,
//                       onChanged: (value) {
//                         setState(() {
//                           _radioValue = 0;
//                           iGroup = true;
//                         });
//                       }),
//                   Text(
//                     "Grup",
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 1,
//                     groupValue: _radioValue,
//                     onChanged: (value) {
//                       setState(() {
//                         _radioValue = 1;
//                         iGroup = false;
//                       });
//                     },
//                   ),
//                   Text(
//                     "Users",
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String textInput = '';
//   bool isSwitched = false;

//   Widget listOfEmployee(String name, String email) {
//     return StatefulBuilder(
//       builder: (context, setState) => Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         width: double.infinity,
//         decoration: BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.white),
//                 top: BorderSide(width: 1, color: Colors.white))),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               name,
//               style: TextStyle(color: Colors.grey),
//             ),
//             Switch(
//               activeColor: Colors.blue,
//               activeTrackColor: Color(0xff007dff),
//               inactiveTrackColor: Colors.grey,
//               onChanged: (value) {
//                 setState(() {
//                   isSwitched = !isSwitched;
//                   selected = name;
//                   selectedEmail = email;
//                   print(
//                       "--------------------------------selectedName-----------------------");
//                   print(selected);
//                   print(selectedEmail);
//                 });
//               },
//               value: isSwitched,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget listOfGroup(String dept) {
//     return StatefulBuilder(
//       builder: (context, setState) => Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         width: double.infinity,
//         decoration: BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.white),
//                 top: BorderSide(width: 1, color: Colors.white))),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               dept,
//               style: TextStyle(color: Colors.grey),
//             ),
//             Switch(
//               activeColor: Colors.blue,
//               activeTrackColor: Color(0xff007dff),
//               inactiveTrackColor: Colors.grey,
//               onChanged: (value) {
//                 setState(() {
//                   isSwitched = !isSwitched;
//                   selected = dept;
//                 });
//               },
//               value: isSwitched,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   reopen() {
//     Padding(
//       padding: const EdgeInsets.only(bottom: 50),
//       child: Container(
//         height: 30,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16))),
//             onPressed: () {
//               FirebaseFirestore.instance
//                   .collection('Hotel List')
//                   .doc(widget.hotel)
//                   .collection('Others')
//                   .doc(widget.taskId)
//                   .update({
//                 "status": "Reopen",
//                 "receiver": cUser.data.name,
//                 "comment": FieldValue.arrayUnion([
//                   {
//                     'commentId': Uuid().v4(),
//                     'commentBody': "has Reopen this request",
//                     'accepted': "",
//                     'esc': "",
//                     'assignTask': "",
//                     'sender': cUser.data.name,
//                     'description': "",
//                     'senderemail': auth.currentUser!.email,
//                     'imageComment': imageUrl,
//                     'time': DateFormat('MMM d, h:mm a')
//                         .format(DateTime.now())
//                         .toString(),
//                   }
//                 ])
//               });
//               // cAccepted.setData("Close");
//               // cAccepted.setSender(cUser.data.name!);
//               widget.scroll.jumpTo(widget.scroll.position.pixels);
//               controller.clear();
//             },
//             child: Container(
//                 alignment: Alignment.center,
//                 height: 25,
//                 width: 70,
//                 child: Text("Reopen"))),
//       ),
//     );
//   }

//   final cUser = Get.put(CUser());
//   // final cAccepted = Get.put(CAccepted());
//   late TextEditingController controller = TextEditingController();

//   var commentSender;
//   String name = " ";
//   bool isTyping = false;
//   RxBool _typing = false.obs;
//   final ImagePicker _picker = ImagePicker();
//   // ignore: unused_field
//   late File _image;
//   String imageName = '';
//   String imageUrl = "";

//   bool get typing => _typing.value;
//   void setTyping(bool n) => _typing.value = n;
//   @override
//   void initState() {
//     getNames();
//     getDeptartement();
//     super.initState();
//     print("--------------------------------------------");
//     print(widget.emailSender);
//     controller = TextEditingController();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   Future<void> getFromGallery(ImageSource source) async {
//     XFile? image = await _picker.pickImage(source: source, imageQuality: 30);

//     setState(() {
//       _image = File(image!.path);
//       imageName = image.name;
//       // Navigator.pop(context);
//     });
//   }

//   Future<void> getFromCamera(ImageSource source) async {
//     XFile? image = await _picker.pickImage(source: source, imageQuality: 30);

//     setState(() {
//       _image = File(image!.path);
//       imageName = image.name;
//       // Navigator.pop(context);
//     });
//   }

//   void imagePickerDialog(context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Container(
//             height: 80,
//             width: 50,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       getFromCamera(ImageSource.camera);
//                     },
//                     child: Container(
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Icon(Icons.camera_alt_rounded),
//                           SizedBox(width: 5),
//                           Text("Camera")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       getFromGallery(ImageSource.gallery);
//                     },
//                     child: Container(
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Icon(Icons.image),
//                           SizedBox(width: 5),
//                           Text("Gallery")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showPopUpMenu(BuildContext context) async {
//     await showMenu(
//         context: context,
//         position: RelativeRect.fromLTRB(50, 600, 0, 20),
//         items: [
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.edit,
//                   color: Colors.grey.shade400,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text("Edit Due Date"),
//               ],
//             ),
//             value: 'Edit Due Date',
//             onTap: () {},
//           ),
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.delete,
//                   color: Colors.grey.shade400,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text("Delete Due Date"),
//               ],
//             ),
//             value: 'Delete Due Date',
//             onTap: () {},
//           ),
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.add,
//                   color: Colors.grey.shade400,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text("Add Due Date"),
//               ],
//             ),
//             value: 'Add Due Date',
//             onTap: () {},
//           ),
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Icon(
//                   widget.status != 'On Hold' ? Icons.pause : Icons.play_arrow,
//                   color: Colors.grey.shade400,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 widget.status != 'On Hold' ? Text("On Hold") : Text("Resume"),
//               ],
//             ),
//             value: 'On Hold',
//             onTap: () async {
//               if (imageName != '') {
//                 String imageExtension = imageName.split('.').last;
//                 final ref = FirebaseStorage.instance.ref(
//                     "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
//                 await ref.putFile(_image);
//                 imageUrl = await ref.getDownloadURL();
//               }
//               await FirebaseFirestore.instance
//                   .collection('Hotel List')
//                   .doc(widget.hotel)
//                   .collection('Others')
//                   .doc(widget.taskId)
//                   .update({
//                 "status": widget.status == 'On Hold' ? "Resume" : "On Hold",
//                 "receiver": cUser.data.name,
//                 "comment": FieldValue.arrayUnion([
//                   {
//                     'commentBody': widget.status == 'On Hold'
//                         ? "has resume this request"
//                         : "has hold this request",
//                     'sender': cUser.data.name,
//                     'description': "",
//                     'senderemail': auth.currentUser!.email,
//                     'imageComment': imageUrl,
//                     'time': DateFormat.yMMMMd()
//                         .add_Hm()
//                         .format(DateTime.now())
//                         .toString(),
//                   }
//                 ])
//               });
//               widget.scroll.jumpTo(widget.scroll.position.maxScrollExtent);
//               controller.clear();
//               // cAccepted.setData("On Hold");
//               // cAccepted.setData("Resume");
//               // cAccepted.setSender(cUser.data.name!);
//             },
//           ),
//         ]);
//   }

//   TextEditingController closetext = TextEditingController();
//   void closeDialog(context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Container(
//               alignment: Alignment.center,
//               height: 115,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "Are you sure want to close this task?",
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   Container(
//                     // padding: EdgeInsets.only(bottom: 10),
//                     // alignment: Alignment.center,
//                     height: 25,
//                     width: 220,
//                     decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextFormField(
//                       controller: closetext,
//                       decoration: InputDecoration(
//                           isCollapsed: true,
//                           border: InputBorder.none,
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: Color(0xff007dff))),
//                         alignment: Alignment.center,
//                         height: 30,
//                         width: 100,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             "No",
//                             style: TextStyle(color: Color(0xff007dff)),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 30,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16))),
//                             onPressed: () async {
//                               // var generatedID = Uuid().v4();
//                               Navigator.pop(context);
//                               if (imageName != '') {
//                                 String imageExtension =
//                                     imageName.split('.').last;
//                                 final ref = FirebaseStorage.instance.ref(
//                                     "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
//                                 await ref.putFile(_image);
//                                 imageUrl = await ref.getDownloadURL();
//                               }
//                               FirebaseFirestore.instance
//                                   .collection('Hotel List')
//                                   .doc(widget.hotel)
//                                   .collection('Others')
//                                   .doc(widget.taskId)
//                                   .update({
//                                 "status": "Close",
//                                 "receiver": cUser.data.name,
//                                 'comment': FieldValue.arrayUnion([
//                                   {
//                                     'commentId': Uuid().v4(),
//                                     'commentBody':
//                                         "has close this request \n${closetext.text}",
//                                     'accepted': "",
//                                     'esc': "",
//                                     'assignTask': "",
//                                     'sender': cUser.data.name,
//                                     'description': "",
//                                     'senderemail': auth.currentUser!.email,
//                                     'imageComment': imageUrl,
//                                     'time': DateFormat('MMM d, h:mm a')
//                                         .format(DateTime.now())
//                                         .toString(),
//                                   }
//                                 ])
//                               });
//                               var result = await FirebaseFirestore.instance
//                                   .collection('users')
//                                   .doc(widget.emailSender)
//                                   .get();
//                               String token = result.data()!["token"];
//                               print(
//                                   "--------------------------------------------");
//                               print(widget.emailSender);
//                               print(token);
//                               Notif().sendNotifToToken(
//                                   token,
//                                   '${widget.location} - "${widget.title}"',
//                                   "${cUser.data.name} close your request");
//                               // cAccepted.setData("Close");
//                               // cAccepted.setSender(cUser.data.name!);
//                               widget.scroll
//                                   .jumpTo(widget.scroll.position.pixels);
//                               controller.clear();
//                             },
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 height: 25,
//                                 width: 70,
//                                 child: Text("Yes"))),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Future<void> haveReceived() async {
//     Fluttertoast.showToast(
//         msg: "You have received this request",
//         backgroundColor: Colors.white,
//         textColor: Colors.black);
//   }

//   void accept() async {
//     if (imageName != '') {
//       String imageExtension = imageName.split('.').last;
//       final ref = FirebaseStorage.instance.ref(
//           "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
//       await ref.putFile(_image);
//       imageUrl = await ref.getDownloadURL();
//     }
//     await FirebaseFirestore.instance
//         .collection('Hotel List')
//         .doc(widget.hotel)
//         .collection('Others')
//         .doc(widget.taskId)
//         .update({
//       "status": "Accepted",
//       "receiver": "by ${cUser.data.name}",
//       "comment": FieldValue.arrayUnion([
//         {
//           'commentId': Uuid().v4(),
//           'commentBody': "",
//           'accepted': "Accepted by ${cUser.data.name}",
//           'esc': "",
//           'assignTask': "",
//           'sender': cUser.data.name,
//           'description': "",
//           'senderemail': auth.currentUser!.email,
//           'imageComment': imageUrl,
//           'time': DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
//         }
//       ])
//     });
//     var result = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.emailSender)
//         .get();
//     String token = result.data()!["token"];
//     print("--------------------------------------------");
//     print(widget.emailSender);
//     print(token);
//     Notif().sendNotifToToken(token, '${widget.location} - "${widget.title}"',
//         "${cUser.data.name} accept your request");
//     widget.scroll.jumpTo(widget.scroll.position.maxScrollExtent);
//     controller.clear();
//     // cAccepted.setData("Accepted");
//     // cAccepted.setSender(cUser.data.name!);
//   }

//   void assignTask() async {
//     if (imageName != '') {
//       String imageExtension = imageName.split('.').last;
//       final ref = FirebaseStorage.instance.ref(
//           "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
//       await ref.putFile(_image);
//       imageUrl = await ref.getDownloadURL();
//     }
//     await FirebaseFirestore.instance
//         .collection('Hotel List')
//         .doc(widget.hotel)
//         .collection('Others')
//         .doc(widget.taskId)
//         .update({
//       "status": "Assigned",
//       "receiver": "to $selected",
//       "comment": FieldValue.arrayUnion([
//         {
//           'commentId': Uuid().v4(),
//           'commentBody': "",
//           'accepted': "",
//           'esc': "",
//           'assignTask':
//               "${cUser.data.name} has assigned this request to $selected",
//           'sender': cUser.data.name,
//           'description': "",
//           'senderemail': auth.currentUser!.email,
//           'imageComment': imageUrl,
//           'time': DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
//         }
//       ])
//     });
//     var result = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(selectedEmail)
//         .get();
//     String token = result.data()!["token"];
//     print("--------------------------------------------");
//     print(widget.emailSender);
//     print(token);
//     if (iGroup == true) {
//       Notif().sendNotif(
//           selected.toLowerCase().removeAllWhitespace,
//           '${widget.location} - "${widget.title}"',
//           "${cUser.data.name} has assigned this request to $selected");
//     } else {
//       Notif().sendNotifToToken(token, '${widget.location} - "${widget.title}"',
//           "${cUser.data.name} has assigned this request to $selected");
//     }
//     Navigator.pop(context);
//     widget.scroll.jumpTo(widget.scroll.position.maxScrollExtent);
//     controller.clear();
//     // cAccepted.setData("Assigned");
//     // cAccepted.setSender(cUser.data.name!);
//   }

//   void sendComment() async {
//     // var generatedID = Uuid().v4();
//     if (imageName != '') {
//       String imageExtension = imageName.split('.').last;
//       final ref = FirebaseStorage.instance.ref(
//           "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
//       await ref.putFile(_image);
//       imageUrl = await ref.getDownloadURL();
//     }
//     await FirebaseFirestore.instance
//         .collection('Hotel List')
//         .doc(widget.hotel)
//         .collection('Others')
//         .doc(widget.taskId)
//         .update({
//       'comment': FieldValue.arrayUnion([
//         {
//           'commentId': Uuid().v4(),
//           'commentBody': controller.text,
//           'accepted': "",
//           'esc': "",
//           'assignTask': "",
//           'sender': cUser.data.name,
//           'description': "",
//           'senderemail': auth.currentUser!.email,
//           'imageComment': imageUrl,
//           'time': DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
//         }
//       ])
//     });
//     // var result = await FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(widget.emailSender)
//     //     .get();
//     // String token = result.data()!["token"];
//     print("--------------------------------------------");
//     print(widget.emailSender);
//     // print(token);
//     Notif().saveTopic(widget.taskId);
//     Notif().sendNotif(
//         widget.taskId.replaceAll(" ", ""),
//         '${widget.location} - "${widget.title}"',
//         '${cUser.data.name}: ${controller.text}');
//     widget.scroll.jumpTo(widget.scroll.position.maxScrollExtent);
//     controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: Container(
//             width: double.infinity,
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16))),
//                     onPressed: () {
//                       closeDialog(context);
//                     },
//                     child: Container(
//                         alignment: Alignment.center,
//                         height: 25,
//                         width: 70,
//                         child: Text("Close"))),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16))),
//                     onPressed: () {
//                       assign(context);
//                     },
//                     child: Container(
//                         alignment: Alignment.center,
//                         height: 25,
//                         width: 70,
//                         child: Text("Assign"))),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16))),
//                   onPressed: () async {
//                     if (widget.emailSender == cUser.data.email) {
//                       await haveReceived();
//                     } else {
//                       accept();
//                     }
//                   },
//                   child: Container(
//                       alignment: Alignment.center,
//                       height: 25,
//                       width: 70,
//                       child: Text("Accept")),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           height: 50,
//           width: double.infinity,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   height: 40,
//                   child: TextFormField(
//                     textAlignVertical: TextAlignVertical.center,
//                     cursorHeight: 21,
//                     onChanged: (value) {
//                       setTyping(value.isNotEmpty);
//                     },
//                     keyboardType: TextInputType.multiline,
//                     textInputAction: TextInputAction.newline,
//                     minLines: 1,
//                     maxLines: 5,
//                     controller: controller,
//                     style: TextStyle(fontSize: 18, overflow: TextOverflow.clip),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(vertical: 0),
//                       prefixIcon: IconButton(
//                         onPressed: () {
//                           imagePickerDialog(context);
//                         },
//                         icon: Icon(
//                           Icons.camera_alt_rounded,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide:
//                               BorderSide(color: Color(0xff007dff), width: 1)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide:
//                               BorderSide(color: Color(0xff007dff), width: 1)),
//                     ),
//                   ),
//                 ),
//               ),
//               Obx(() {
//                 return Container(
//                   child: typing
//                       ? IconButton(
//                           padding: EdgeInsets.all(0),
//                           splashRadius: 20,
//                           onPressed: () async {
//                             controller.text.isEmpty
//                                 ? Fluttertoast.showToast(
//                                     msg: "Please input text",
//                                     textColor: Colors.black,
//                                     backgroundColor: Colors.white)
//                                 : sendComment();
//                           },
//                           icon: Icon(
//                             Icons.send,
//                             color: Color(0xff007dff),
//                           ))
//                       : IconButton(
//                           padding: EdgeInsets.all(0),
//                           splashRadius: 20,
//                           onPressed: () {
//                             _showPopUpMenu(context);
//                           },
//                           icon: Icon(
//                             Icons.more_vert_rounded,
//                             color: Color(0xff007dff),
//                           )),
//                 );
//               })
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
