import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:post_app/Screens/chatroom/widget/right_bubble/accepted_bubble.dart';

import 'add_schedule_right.dart';
import 'assign_bubble_right.dart';
import 'bubble_edit_location_right.dart';
import 'delete_schedule_bubble.dart';
import 'hold_right.dart';
import 'my_message.dart';
import 'resume_right.dart';
import 'title_changes_right.dart';

class RightBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final Timestamp time;
  final String setDate;
  final String setTime;
  final String deleteSchedule;
  final String editLocation;
  final String resume;
  final String hold;
  final String senderMsgName;
  final String message;
  final String description;
  final String isAccepted;
  final String esc;
  final String titleChanging;
  final String assignSender;
  final String assignTo;
  final List<dynamic> image;
  const RightBubble(
      {super.key,
      required this.commentList,
      required this.time,
      required this.senderMsgName,
      required this.isAccepted,
      required this.esc,
      required this.assignSender,
      required this.assignTo,
      required this.image,
      required this.message,
      required this.titleChanging,
      required this.setDate,
      required this.setTime,
      required this.deleteSchedule,
      required this.editLocation,
      required this.resume,
      required this.hold,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      //buble chat yg tampil jika ada kita sbg pengirim pesan..................................
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        (isAccepted != '')
            ? const SizedBox()
            : (assignTo != '')
                ? const SizedBox()
                : (titleChanging != '')
                    ? const SizedBox()
                    : (resume != '')
                        ? const SizedBox()
                        : (hold != '')
                            ? const SizedBox()
                            : (setTime != '')
                                ? const SizedBox()
                                : (editLocation != '')
                                    ? const SizedBox()
                                    : (deleteSchedule != '')
                                        ? const SizedBox()
                                        : (message.isEmpty &&
                                                image.isEmpty &&
                                                description.isEmpty)
                                            ? const SizedBox()
                                            : MyMessage(
                                                commentList: commentList,
                                                time: time.toDate().toString(),
                                                message: message,
                                                image: image,
                                                senderMsgName: senderMsgName,
                                                description: description,
                                              ),
        //bubble ketike kita hold task
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        hold == ''
            ? const SizedBox()
            : HoldBubble(hold: hold, time: time.toDate().toString()),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketike kita resume task
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        resume == ''
            ? const SizedBox()
            : Resume(resume: resume, time: time.toDate().toString()),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketike kita menambah kan shcedule
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        setTime.isEmpty
            ? const SizedBox()
            : AddSchedule(
                addSchedule: setDate + setTime, time: time.toDate().toString()),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita menghapus schedule
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        deleteSchedule == ''
            ? const SizedBox()
            : DeleteScheduleBubble(
                deleteSchedule: deleteSchedule, time: time.toDate().toString()),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita mengedit lokasi
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        editLocation == ''
            ? const SizedBox()
            : EditLoactionBubble(
                newLocation: editLocation, time: time.toDate().toString()),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita menerima task...
        SizedBox(
          height: isAccepted.isEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        (isAccepted == '')
            ? const SizedBox()
            : AcceptedBubbleRight(
                time: time.toDate().toString(), isAccepted: isAccepted),
        SizedBox(
          height: isAccepted.isEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        // widget yg ditampilkan ketika kita assign request ke user lain.......................
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        assignTo == ''
            ? const SizedBox()
            : AssignBubnleRight(
                assignSender: assignSender,
                time: time.toDate().toString(),
                assignTo: assignTo),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika user mengganti title
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        titleChanging == ''
            ? const SizedBox()
            : TitleChangesRight(
                titleChanges: titleChanging,
                time: time.toDate().toString(),
                changer: senderMsgName),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        // status esc................................
        SizedBox(
          height: esc == '' ? 0 : 10,
        ),
        esc == ''
            ? const SizedBox()
            : SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 40,
                      child: Text(
                        "Jun 03, 09.00 AM",
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey, height: 1.5),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: 250,
                          child: const Text(
                            "Escalation after 5 minutes",
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.history,
                          color: Colors.blue,
                          size: 30,
                        ),

                        // Icon(
                        //   Icons.check_circle,
                        //   color: Colors.green,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
        SizedBox(
          height: esc == '' ? 0 : 10,
        ),
      ],
    );
  }
}
