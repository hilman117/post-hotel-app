import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/ios_view/ios_image_picker.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../common_widget/dropdown-option_field.dart';
import '../create/create_request_controller.dart';
import '../create/widget/list_images.dart';
import '../settings/setting_provider.dart';

class IosCreatePage extends StatefulWidget {
  const IosCreatePage(
      {super.key, required this.isTask, required this.selectedDept});

  final bool isTask;
  final Departement? selectedDept;

  @override
  State<IosCreatePage> createState() => _IosCreatePageState();
}

class _IosCreatePageState extends State<IosCreatePage> {
  final String _selectedTitle = "";
  final String _selectedLoaction = "";
  TextEditingController decsCOntroller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final user = Get.put(CUser());

  // @override
  // void dispose() {
  //   decsCOntroller.dispose();
  //   super.dispose();
  // }
  static final GlobalKey _locationKey = GlobalKey(); // letakkan di state
  static final GlobalKey _titleKey = GlobalKey(); // letakkan di state

  @override
  Widget build(BuildContext context) {
    final bilingual = AppLocalizations.of(context);
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final listDept = Provider.of<List<Departement>>(context);
    final event = Provider.of<CreateRequestController>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: theme.scaffoldBackgroundColor, // Android saja
          systemNavigationBarColor: theme.scaffoldBackgroundColor),
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        DropdownOptionField.hidePopup(context);
      },
      child:
          Consumer<CreateRequestController>(builder: (context, value, child) {
        return PopScope(
          canPop: value.canPop,
          onPopInvokedWithResult: (value, _) async {
            if (!value && DropdownOptionField.overlayEntry != null) {
              DropdownOptionField.hidePopup(context);
            }
          },
          child: CupertinoPageScaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CupertinoColors.systemGroupedBackground,
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.isTask
                          ? widget.selectedDept!.departement!
                          : "Lost and found",
                      style: TextStyle(color: theme.focusColor),
                    )
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Material(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: ListView(
                      children: [
                        //WIDGET SEARCH LOCATION FIELD
                        CupertinoListSection.insetGrouped(
                            margin: const EdgeInsets.all(0),
                            header: Text(
                              bilingual!.location,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            children: [
                              CupertinoListTile(
                                title: Consumer2<HomeController,
                                        CreateRequestController>(
                                    builder: (context, value, value2, child) {
                                  return DropdownOptionField(
                                    search: locationController,
                                    listOption: value.listLocation,
                                    globalKey: _locationKey,
                                    value: value2.selectedLocatioin,
                                    hintText: bilingual.typeLocation,
                                    textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: value2.selectedLocatioin.isEmpty
                                            ? Colors.grey.shade400
                                            : Colors.black),
                                    onItemSelected: (item, index) {
                                      event.selectLocation(item);
                                      event.clearSearchTitle();
                                      locationController.clear();
                                      DropdownOptionField.hidePopup(context);
                                    },
                                    onChanged: (location) =>
                                        event.searchLocation(
                                            value.listLocation, location),
                                    onCancel: () => event.clearLocation(),
                                  );
                                }),
                                leading: Icon(
                                  CupertinoIcons.location,
                                  size: 20.sp,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ]),
                        //WIDGET SEARCH TITLE FIELD
                        if (widget.isTask)
                          CupertinoListSection.insetGrouped(
                              margin: const EdgeInsets.all(0),
                              header: Text(
                                bilingual.title,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                                textAlign: TextAlign.left,
                              ),
                              children: [
                                CupertinoListTile(
                                  title: Consumer2<HomeController,
                                          CreateRequestController>(
                                      builder: (context, value, value2, child) {
                                    return DropdownOptionField(
                                      search: titleController,
                                      listOption: widget.selectedDept!.title!,
                                      globalKey: _titleKey,
                                      value: value2.selectedTitle,
                                      hintText: bilingual.inputTitle,
                                      textStyle: TextStyle(
                                          fontSize: 16.sp,
                                          color: value2.selectedTitle.isEmpty
                                              ? Colors.grey.shade400
                                              : Colors.black),
                                      onItemSelected: (item, index) {
                                        event.selectTitle(item);
                                        titleController.clear();
                                        event.clearSearchTitle();
                                        DropdownOptionField.hidePopup(context);
                                      },
                                      onChanged: (title) =>
                                          event.getTitle(title),
                                      onCancel: () => event.clearTitle(),
                                    );
                                  }),
                                  leading: Icon(
                                    CupertinoIcons.t_bubble,
                                    size: 20.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ]),
                        //WIDGET INPUT ITEM NAME LOST AND FOUND FIELD
                        if (!widget.isTask)
                          CupertinoListSection.insetGrouped(
                              margin: const EdgeInsets.all(0),
                              header: Text(
                                bilingual.nameOfItem,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                                textAlign: TextAlign.left,
                              ),
                              children: [
                                CupertinoListTile(
                                  title: Consumer2<HomeController,
                                          CreateRequestController>(
                                      builder: (context, value, value2, child) {
                                    return CupertinoTextField(
                                      suffix: value2.nameItemFound.isNotEmpty
                                          ? InkWell(
                                              onTap: () =>
                                                  event.clearNameItemtyping(),
                                              child: Icon(
                                                  CupertinoIcons.xmark_circle,
                                                  color: Colors.grey,
                                                  size: 20.sp),
                                            )
                                          : null,
                                      onChanged: (value) =>
                                          event.listenNameItemtyping(value),
                                      controller: value2.nameItem,
                                      textInputAction: TextInputAction.done,
                                      placeholder: bilingual.nameOfItem,
                                      decoration:
                                          const BoxDecoration(border: null),
                                    );
                                  }),
                                  leading: Icon(
                                    CupertinoIcons.archivebox,
                                    size: 20.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ]),

                        SizedBox(
                          height: fullWidth < maxWidth ? 10.h : 10,
                        ),
                        CupertinoFormSection.insetGrouped(
                            margin: const EdgeInsets.all(0),
                            header: Text(
                              bilingual.description,
                              textAlign: TextAlign.left,
                            ),
                            children: [
                              Consumer<CreateRequestController>(
                                  builder: (context, value, child) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: fullWidth < maxWidth ? 150.h : 300,
                                  child: CupertinoTextField(
                                    prefix: Icon(
                                      CupertinoIcons.text_justifyleft,
                                      color: Colors.grey.shade400,
                                    ),
                                    prefixMode:
                                        OverlayVisibilityMode.notEditing,
                                    style: TextStyle(color: theme.focusColor),
                                    // placeholderStyle: TextStyle(color: theme.hintColor),
                                    controller: decsCOntroller,
                                    textAlignVertical: TextAlignVertical.top,
                                    minLines: 1,
                                    maxLines: 10,
                                    placeholder: bilingual.description,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    decoration: BoxDecoration(
                                        border: null,
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    // placeholderStyle: TextStyle(
                                    //     letterSpacing: -0.5,
                                    //     fontSize: fullWidth < maxWidth ? 16.sp : 16),
                                  ),
                                );
                              }),
                            ]),
                        SizedBox(
                          height: fullWidth < maxWidth ? 20.h : 20,
                        ),

                        CupertinoListSection.insetGrouped(
                          margin: const EdgeInsets.all(0),
                          children: [
                            CupertinoListTile(
                              leading: Icon(CupertinoIcons.photo_on_rectangle,
                                  color: CupertinoColors.activeBlue,
                                  size: fullWidth < maxWidth ? 20.sp : 20),
                              title: Text(
                                bilingual.photo,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              onTap: () {
                                FocusNode().unfocus();
                                iosImagePicker(context, true);
                              },
                              trailing: SizedBox(
                                  height: 40.h,
                                  child: Consumer<CreateRequestController>(
                                      builder: (context, value, child) {
                                    if (value.isLoadImage) {
                                      return Lottie.asset(
                                          "images/loadimage.json");
                                    }
                                    return ListImages(
                                      getHeight: 250.h,
                                      getWidht: 200.w,
                                    );
                                  })),
                            ),
                            if (widget.isTask)
                              CupertinoListTile(
                                leading: Icon(CupertinoIcons.clock,
                                    color: CupertinoColors.activeBlue,
                                    size: fullWidth < maxWidth ? 20.sp : 20),
                                title: Text(
                                  bilingual.setTime,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                onTap: () =>
                                    Provider.of<CreateRequestController>(
                                            context,
                                            listen: false)
                                        .timePIcker(context, bilingual),
                                trailing: Consumer<CreateRequestController>(
                                    builder: (context, value, child) {
                                  if (value.hour.isNotEmpty &&
                                      value.minute.isNotEmpty) {
                                    return Row(
                                      children: [
                                        Text(
                                          "${value.hour}:${value.minute}",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: fullWidth < maxWidth
                                                  ? 15.sp
                                                  : 15),
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        InkWell(
                                          onTap: () => event.clearSchedule(),
                                          child: Icon(
                                            CupertinoIcons.xmark_circle,
                                            size: 18.sp,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                }),
                              ),
                            if (widget.isTask)
                              CupertinoListTile(
                                leading: Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    color: CupertinoColors.activeBlue,
                                    size: fullWidth < maxWidth ? 20.sp : 20),
                                title: Text(
                                  bilingual.addDueDate,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                onTap: () =>
                                    Provider.of<CreateRequestController>(
                                            context,
                                            listen: false)
                                        .dateTimPicker(context),
                                trailing: Consumer<CreateRequestController>(
                                    builder: (context, value, child) {
                                  if (value.datePicked.isNotEmpty) {
                                    return Row(
                                      children: [
                                        Text(
                                            DateFormat('EE, MMM d').format(
                                                DateTime.parse(
                                                    value.datePicked)),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: fullWidth < maxWidth
                                                    ? 15.sp
                                                    : 15)),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        InkWell(
                                          onTap: () => event.clearDate(),
                                          child: Icon(
                                            CupertinoIcons.xmark_circle,
                                            size: 18.sp,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                }),
                              ),
                            if (!widget.isTask)
                              CupertinoListTile(
                                leading: Icon(CupertinoIcons.question_diamond,
                                    color: CupertinoColors.activeBlue,
                                    size: fullWidth < maxWidth ? 20.sp : 20),
                                title: Text(
                                  "${bilingual.valuableItem}?",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                trailing: Consumer<CreateRequestController>(
                                    builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: 0.7,
                                    child: CupertinoSwitch(
                                        inactiveTrackColor:
                                            Colors.grey.shade200,
                                        value: value.isValueable,
                                        onChanged: (val) =>
                                            event.valueableItemOrNot(val)),
                                  );
                                }),
                              ),
                          ],
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        Consumer2<CreateRequestController, HomeController>(
                            builder: (context, value, value2, child) {
                          return SizedBox(
                            height: 35.h,
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              color: CupertinoColors.systemBlue,
                              onPressed: value.isLoadImage
                                  ? null
                                  : () {
                                      if (widget.isTask) {
                                        // List<String> lisTitle =
                                        //     value2.listTitle.map((e) => e.title!).toList();
                                        event.tasks(
                                            Provider.of<SettingProvider>(
                                                    context,
                                                    listen: false)
                                                .imageUrl,
                                            context,
                                            user.data.hotel!,
                                            user.data.uid!,
                                            decsCOntroller,
                                            user.data.name!,
                                            user.data.department!,
                                            user.data.email!,
                                            _selectedTitle,
                                            widget.selectedDept!,
                                            value2.listLocation,
                                            listDept);
                                      } else {
                                        event.lfReport(
                                            context,
                                            value2.dataHotel!.deptToStoreLF!,
                                            user.data.hotel!,
                                            user.data.uid!,
                                            decsCOntroller,
                                            user.data.name!,
                                            user.data.email!,
                                            _selectedLoaction,
                                            decsCOntroller.text,
                                            value2.listDepartement!);
                                      }
                                    },
                              child: Text(
                                bilingual.send,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.5,
                                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }
}

class IosCreateInputWidget extends StatelessWidget {
  const IosCreateInputWidget({
    super.key,
    required this.event,
    required this.theme,
    required this.fullWidth,
    required this.maxWidth,
    required this.hintLabel,
    required this.optionsBuilder,
    required this.keywordSearch,
    this.onSelected,
  });

  final CreateRequestController event;
  final ThemeData theme;
  final double fullWidth;
  final double maxWidth;
  final String hintLabel;
  final FutureOr<Iterable<String>> Function(TextEditingValue) optionsBuilder;
  final String keywordSearch;
  final void Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeController, CreateRequestController>(
      builder: (context, value, val, child) {
        return Autocomplete<String>(
            displayStringForOption: (option) => option,
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return CupertinoTextField(
                  style: TextStyle(color: theme.focusColor),
                  textInputAction: TextInputAction.next,
                  placeholder: hintLabel,
                  // placeholderStyle: TextStyle(color: theme.hintColor),
                  focusNode: focusNode,
                  controller: textEditingController);
            },
            optionsBuilder: optionsBuilder,
            onSelected: onSelected,
            optionsViewBuilder: (context, onSelected, options) {
              List<String> itemList = options.toList();
              return Material(
                  elevation: 4,
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 300.h, maxWidth: 300.w),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0.0, 0.0),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    color: mainColor)
                              ],
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            itemCount: itemList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String item = itemList[index];
                              return CupertinoListTile(
                                onTap: () => onSelected(item),
                                title: RichText(
                                    text: TextSpan(
                                        children: List<TextSpan>.generate(
                                            item.length, (index) {
                                  return TextSpan(
                                      text: item[index],
                                      style: TextStyle(
                                          color: event.colorOfMatchFont(theme,
                                              item[index], keywordSearch),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                          fontSize: fullWidth < maxWidth
                                              ? 14.sp
                                              : 14));
                                }))),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ),
                    ),
                  ));
            });
      },
    );
  }
}

class IosInputLocation extends StatelessWidget {
  const IosInputLocation({
    super.key,
    required this.event,
    required this.theme,
    required this.fullWidth,
    required this.maxWidth,
    required this.hintLabel,
    required this.optionsBuilder,
    required this.keywordSearch,
    this.onSelected,
  });

  final CreateRequestController event;
  final ThemeData theme;
  final double fullWidth;
  final double maxWidth;
  final String hintLabel;
  final FutureOr<Iterable<String>> Function(TextEditingValue) optionsBuilder;
  final String keywordSearch;
  final void Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeController, CreateRequestController>(
      builder: (context, value, val, child) {
        return Autocomplete<String>(
            displayStringForOption: (option) => option,
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return CupertinoTextField(
                  style: TextStyle(color: theme.focusColor),
                  textInputAction: TextInputAction.next,
                  placeholder: hintLabel,
                  // placeholderStyle: TextStyle(color: theme.hintColor),
                  focusNode: focusNode,
                  controller: textEditingController);
            },
            optionsBuilder: optionsBuilder,
            onSelected: onSelected,
            optionsViewBuilder: (context, onSelected, options) {
              List<String> itemList = options.toList();
              return Material(
                  elevation: 4,
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 300.h, maxWidth: 300.w),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0.0, 0.0),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    color: mainColor)
                              ],
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            itemCount: itemList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String item = itemList[index];
                              return CupertinoListTile(
                                onTap: () => onSelected(item),
                                title: RichText(
                                    text: TextSpan(
                                        children: List<TextSpan>.generate(
                                            item.length, (index) {
                                  return TextSpan(
                                      text: item[index],
                                      style: TextStyle(
                                          color: event.colorOfMatchFont(theme,
                                              item[index], keywordSearch),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                          fontSize: fullWidth < maxWidth
                                              ? 14.sp
                                              : 14));
                                }))),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ),
                    ),
                  ));
            });
      },
    );
  }
}

class AutoCompleteLcation extends StatelessWidget {
  const AutoCompleteLcation({
    super.key,
    required this.event,
    required this.theme,
    required this.fullWidth,
    required this.maxWidth,
    required this.hintLabel,
    required this.optionsBuilder,
    required this.onSelectedFunction,
    required this.keywordSearch,
  });

  final CreateRequestController event;
  final ThemeData theme;
  final double fullWidth;
  final double maxWidth;
  final String hintLabel;
  final FutureOr<Iterable<String>> Function(TextEditingValue) optionsBuilder;
  final AutocompleteOnSelected<String>? onSelectedFunction;
  final String keywordSearch;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, child) {
        return Autocomplete<String>(
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return CupertinoTextField(
                autofocus: true,
                style: TextStyle(color: theme.focusColor),
                textInputAction: TextInputAction.next,
                placeholder: hintLabel,
                focusNode: focusNode,
                controller: textEditingController,
              );
            },
            optionsBuilder: optionsBuilder,
            onSelected: onSelectedFunction,
            optionsViewBuilder: (context, onSelected, options) {
              List<String> itemList = options.toList();
              return Material(
                  elevation: 4,
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 300.h, maxWidth: 300.w),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0.0, 0.0),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    color: mainColor)
                              ],
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            itemCount: itemList.length,
                            itemBuilder: (context, index) {
                              String item = itemList[index];
                              return CupertinoListTile(
                                onTap: () => onSelected(item),
                                title: RichText(
                                    text: TextSpan(
                                        children: List<TextSpan>.generate(
                                            item.length, (index) {
                                  return TextSpan(
                                      text: item[index],
                                      style: TextStyle(
                                          color: event.colorOfMatchFont(theme,
                                              item[index], keywordSearch),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                          fontSize: fullWidth < maxWidth
                                              ? 14.sp
                                              : 14));
                                }))),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ),
                    ),
                  ));
            });
      },
    );
  }
}
