import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../../homescreen/widget/card_request.dart';

Future deleteSchedule(BuildContext context, String taskId, String emailSender,
    String oldDate, String oldTime, String location) {
  final provider = Provider.of<PopUpMenuProvider>(context, listen: false);
  final app = AppLocalizations.of(context)!;
  return showDialog(
      context: context,
      builder: (context) => Consumer<CreateRequestController>(
          builder: (context, value, child) => AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                content: SizedBox(
                  height: height * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Are you sure want to delete due date?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new date
                      SizedBox(
                        height: height * 0.05,
                        width: width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Text(value.datePicked == ''
                                ? ''
                                : DateFormat('EE, d MMM')
                                    .format(DateTime.parse(value.datePicked))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new time
                      SizedBox(
                        height: height * 0.05,
                        width: width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Text(value.selectedTime),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  SizedBox(
                    width: width * 0.25,
                    height: height * 0.04,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            elevation: 0, foregroundColor: mainColor),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(app.cancel)),
                  ),
                  SizedBox(
                    width: width * 0.25,
                    height: height * 0.04,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: mainColor),
                      child: const Text("Delete"),
                      onPressed: () {
                        provider.deleteSchedule(
                            context, taskId, emailSender, location);
                        Provider.of<CreateRequestController>(context,
                                listen: false)
                            .changeDate(''); // Navigator.pop(context);
                        Provider.of<CreateRequestController>(context,
                                listen: false)
                            .changeTime(''); // Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )));
}
