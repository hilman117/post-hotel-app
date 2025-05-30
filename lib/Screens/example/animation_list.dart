// import 'package:flutter/material.dart';

// import 'user_model.dart';

// class AnimatedListDemo extends StatefulWidget {
//   _AnimatedListDemoState createState() => _AnimatedListDemoState();
// }

// class _AnimatedListDemoState extends State<AnimatedListDemo> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey();

//   void addUser() {
//     int index = listData.length;
//     listData.add(
//       UserModel(
//         firstName: "Norbert",
//         lastName: "Kozsir",
//         profileImageUrl:
//             "https://pbs.twimg.com/profile_images/970033173013958656/Oz3SLVat_400x400.jpg",
//       ),
//     );
//     _listKey.currentState!
//         .insertItem(index, duration: Duration(milliseconds: 300));
//   }

//   void deleteUser(int index) {
//     var user = listData.removeAt(index);
//     _listKey.currentState!.removeItem(
//       index,
//       (BuildContext context, Animation<double> animation) {
//         return FadeTransition(
//           opacity:
//               CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
//           child: SizeTransition(
//             sizeFactor:
//                 CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
//             axisAlignment: 0.0,
//             child: _buildItem(user, index),
//           ),
//         );
//       },
//       duration: Duration(milliseconds: 500),
//     );
//   }

//   Widget _buildItem(UserModel user, int index) {
//     return ListTile(
//       key: ValueKey<UserModel>(user),
//       title: Text(user.firstName),
//       subtitle: Text(user.lastName),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(user.profileImageUrl),
//       ),
//       onLongPress: index != null ? () => deleteUser(index) : null,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Animated List Demo"),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: addUser,
//         ),
//       ),
//       body: SafeArea(
//         child: AnimatedList(
//           key: _listKey,
//           initialItemCount: listData.length,
//           itemBuilder: (BuildContext context, int index, animation) {
//             return FadeTransition(
//               opacity: animation,
//               child: _buildItem(listData[index], index),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
