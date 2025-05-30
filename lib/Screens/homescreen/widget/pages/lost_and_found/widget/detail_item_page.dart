import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:post_app/models/lf_chat_model.dart';

class DetailItemPage extends StatefulWidget {
  const DetailItemPage({super.key, required this.lfModel});
  final TaskModel lfModel;

  @override
  State<DetailItemPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  final user = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 160.0,
            title: Text(
              widget.lfModel.title!,
              style: TextStyle(color: theme.focusColor),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.lfModel.image!.first,
                child: Image.network(
                  widget.lfModel.image!.first,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        height: 80.h,
                        width: 90.w,
                        color: theme.cardColor,
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80.h,
                      width: 90.w,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Hotel List')
                .doc(user.data.hotelid)
                .collection('lost and found')
                .doc(widget.lfModel.id)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var commentList = (snapshot.data!.data()
                    as Map<String, dynamic>)['comment'] as List;
                List<LFChatModel> lfChat =
                    commentList.map((e) => LFChatModel.fromJson(e)).toList();
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      LFChatModel lfChatModel = lfChat[index];
                      return Container(
                        alignment: user.data.name == lfChatModel.sender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: user.data.name == lfChatModel.sender
                                ? 60.sp
                                : 10.sp,
                            right: user.data.name != lfChatModel.sender
                                ? 60.sp
                                : 10.sp,
                            bottom: 7.sp,
                            top: 7.sp),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.blue.shade50,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lfChatModel.sender!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.focusColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                lfChatModel.commentBody!,
                                style: TextStyle(color: theme.focusColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: lfChat.length,
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
