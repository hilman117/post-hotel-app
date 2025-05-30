import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';
import '../../controller/c_user.dart';
import '../../models/departement_model.dart';
import 'widget/box_description.dart';
import 'widget/execute_buttons.dart';
import 'widget/general_form.dart';
import 'widget/list_images.dart';
import 'widget/schedule.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest(
      {super.key,
      required this.listTitle,
      required this.selectedDept,
      required this.isTask});
  final List<String> listTitle;
  final Departement selectedDept;
  final bool isTask;

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final cUser = Get.put(CUser());

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .clearData();
        Provider.of<CreateRequestController>(context, listen: false)
            .clearSchedule();
        // Provider.of<CreateRequestController>(context, listen: false)
        //     .restartVariable();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widht = Get.width;
    double height = Get.height;
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: false,
          foregroundColor: theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              splashRadius: fullWidth < maxWidth ? 20.sp : 20,
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: theme.focusColor,
                size: fullWidth < maxWidth ? 20.sp : 20,
              )),
          title: widget.isTask
              ? Text(
                  "${app!.sendThisTo} ${widget.selectedDept.departement}",
                  style: TextStyle(
                      color: theme.focusColor,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14),
                )
              : Text("Lost And Found",
                  style: TextStyle(
                      color: theme.focusColor,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14)),
          titleTextStyle:
              TextStyle(fontSize: fullWidth < maxWidth ? 18.sp : 18),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: fullWidth < maxWidth ? 8.sp : 8,
                  vertical: fullWidth < maxWidth ? 8.sp : 8),
              child: Consumer2<CreateRequestController, HomeController>(
                builder: (context, value, value2, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InputLocation(
                    //   callback: () {},
                    // ),
                    SizedBox(height: fullWidth < maxWidth ? 10.h : 10),
                    GeneralForm(
                        title: widget.isTask != true
                            ? 'Name of Item:'
                            : "${AppLocalizations.of(context)!.title}   ",
                        hintForm: value.selectedTitle == 'Input Title'
                            ? AppLocalizations.of(context)!.inputTitle
                            : value.selectedTitle,
                        callback: () async {
                          provider.clearSearchTitle();
                          // titleList(context, '', "", widget.listTitle);
                        },
                        icons: Icons.arrow_drop_down_rounded,
                        colors: mainColor,
                        isTask: widget.isTask),
                    SizedBox(height: height * 0.010),
                    BoxDescription(
                      controller: value.descriptionController,
                    ),
                    SizedBox(height: height * 0.025),
                    SchedulePicker(
                      isTask: widget.isTask,
                    ),
                    SizedBox(height: height * 0.010),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      color: theme.scaffoldBackgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.attachment,
                              style: TextStyle(
                                  color: theme.focusColor, fontSize: 15)),
                          SizedBox(height: height * 0.010),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.linear,
                            switchOutCurve: Curves.linear,
                            child: value.imagesList.isEmpty
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    // height: height * 0.1,
                                    child: ExecuteButton().imageButton(context))
                                : ListImages(
                                    getHeight: Get.height,
                                    getWidht: Get.width,
                                  ),
                          ),
                          SizedBox(height: height * 0.010),
                          ExecuteButton().sendButton(
                            context,
                            widht,
                            () {
                              if (widget.isTask) {
                                // provider.tasks(
                                //     Provider.of<SettingProvider>(context,
                                //             listen: false)
                                //         .imageUrl,
                                //     context,
                                //     cUser.data.hotelid!,
                                //     cUser.data.uid!,
                                //     value.descriptionController,
                                //     cUser.data.name!,
                                //     cUser.data.department!,
                                //     cUser.data.email!,
                                //     value.selectedLocation.text,
                                //     value.selectedTitle,
                                //     widget.selectedDept.departementIcon!,
                                //     value.selectedDept,
                                //     value2.listLocation,
                                //     widget.selectedDept.title!);
                              } else {
                                // provider.lfReport(
                                //     context,
                                //     "",
                                //     cUser.data.hotelid!,
                                //     cUser.data.uid!,
                                //     value.descriptionController,
                                //     cUser.data.name!,
                                //     cUser.data.email!,
                                //     value.selectedLocation.text,
                                //     value.descriptionController.text);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
