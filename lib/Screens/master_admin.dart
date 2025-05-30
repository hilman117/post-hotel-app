import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/sign_in/signin.dart';
import 'package:post_app/variable.dart';

import 'register_new_hotel/register_new_hotel.dart';

class MasterAdmin extends StatefulWidget {
  const MasterAdmin({super.key});

  @override
  State<MasterAdmin> createState() => _MasterAdminState();
}

class _MasterAdminState extends State<MasterAdmin> {
  Future<QuerySnapshot<Map<String, dynamic>>> getHotelData() async {
    return FirebaseFirestore.instance.collection(hotelCollection).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Master Admin",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const RegisterNewHotel());
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => getHotelData(),
          backgroundColor: Colors.white,
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: getHotelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No data available'));
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                padding: EdgeInsets.all(8.sp),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var hotel = data[index].data();
                  var hotelName = hotel["hotelName"];
                  int modulo = index % 2;
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(3.sp),
                      padding: EdgeInsets.all(8.0.sp),
                      decoration: BoxDecoration(
                          boxShadow: modulo == 0
                              ? [
                                  BoxShadow(
                                      offset: const Offset(0.5, 0.5),
                                      color: Colors.grey.shade200)
                                ]
                              : null),
                      child: Text(
                        hotelName ?? 'No Name',
                        style: TextStyle(fontSize: 20.sp, color: Colors.black),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
