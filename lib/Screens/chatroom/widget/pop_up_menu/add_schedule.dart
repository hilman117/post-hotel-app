import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../../homescreen/widget/card_request.dart';

Future addSchedule(BuildContext context, String taskId, String emailSender,
    String oldDate, String oldTime, String location) {
  final provider = Provider.of<CreateRequestController>(context, listen: false);
  final app = AppLocalizations.of(context)!;
  return showDialog(
      context: context,
      builder: (context) => Consumer<CreateRequestController>(
          builder: (context, value, child) => AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                content: SizedBox(
                  height: height * 0.18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.addDueDate,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new date
                      InkWell(
                        onTap: () => provider.dateTimPicker(context),
                        child: SizedBox(
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
                                  : DateFormat('EE, d MMM').format(
                                      DateTime.parse(value.datePicked))),
                              const Spacer(),
                              const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new time
                      InkWell(
                        onTap: () => provider.timePIcker(context, app),
                        child: SizedBox(
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
                              const Spacer(),
                              const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ],
                          ),
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
                          Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .cancelButton(oldDate, oldTime);
                          // ignore: use_build_context_synchronously
                          Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .clearTime();
                          // ignore: use_build_context_synchronously
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
                      onPressed: value.newDate != '' || value.newTime != ''
                          ? () async {
                              try {
                                if (value.newDate != '') {
                                  Provider.of<PopUpMenuProvider>(context,
                                          listen: false)
                                      .storeNewDate(context, taskId, oldDate,
                                          emailSender, location);
                                }
                                if (value.newTime != '') {
                                  Provider.of<PopUpMenuProvider>(context,
                                          listen: false)
                                      .storeNewTime(context, taskId, oldTime,
                                          emailSender, location);
                                  Provider.of<CreateRequestController>(context,
                                          listen: false)
                                      .clearTime();
                                }
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                            }
                          : null,
                      child: const Text("Add"),
                    ),
                  ),
                ],
              )));
}
