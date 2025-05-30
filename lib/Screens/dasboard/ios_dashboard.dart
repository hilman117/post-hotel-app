import 'dart:async';
import 'dart:io';

import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/Screens/homescreen/widget/pages/lost_and_found/lost_and_found.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/global_function.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/notification_controller.dart';
import 'package:provider/provider.dart';

import '../../../../models/tasks.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../homescreen/home_controller.dart';
import '../homescreen/widget/dialog_departement_list.dart';
import '../ios_view/ios_card_requst.dart';
import '../ios_view/ios_profile.dart';
import '../ios_view/ios_sorting_task_bottom_sheet.dart';

class IosDashBoard extends StatefulWidget {
  const IosDashBoard({super.key, required this.list});
  final List<Departement> list;
  static late CupertinoTabController tabController;

  @override
  State<IosDashBoard> createState() => _IosDashBoardState();
}

class _IosDashBoardState extends State<IosDashBoard>
    with SingleTickerProviderStateMixin {
  // late ScrollController controller;

  final cUser = Get.put(CUser());
  // String? _getFoto;
  Animatable<Color?> bgColor = TweenSequence<Color?>([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
  ]);

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Timer? _timer;
  TextEditingController searchInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    IosDashBoard.tabController = CupertinoTabController(initialIndex: 0);
    FirebaseMessaging.onMessage.listen(
      (event) async {
        if (event.data.isNotEmpty) {
          await NotificationController.createNewNotification(
            event,
            box!.get('isOnDuty') ?? true,
            box!.get('ReceiveNotifWhenAccepted') ?? true,
            box!.get('ReceiveNotifWhenClose') ?? true,
            box!.get('sendChatNotif') ?? true,
          );
        }
      },
    );
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        reverseDuration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _startAnimationTimer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      Future.microtask(
        () => Provider.of<HomeController>(context, listen: false)
            .selectScreens(0, IosDashBoard.tabController),
      );
      // Ensure this runs every time the dependencies change
    }

    final theme = Theme.of(context);
    _colorAnimation = _controller.drive(
      TweenSequence<Color?>(
        [
          TweenSequenceItem(
            tween: ColorTween(
              begin: theme.cardColor,
              end: Colors.blue.shade100,
            ),
            weight: 1.0,
          ),
          TweenSequenceItem(
            tween: ColorTween(
              begin: Colors.blue.shade100,
              end: theme.cardColor,
            ),
            weight: 1.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer!.cancel();
    super.dispose();
  }

  void _startAnimationTimer() {
    const animationDuration = Duration(minutes: 1);
    const animationInterval = Duration(seconds: 3);

    _timer = Timer.periodic(animationDuration + animationInterval, (_) {
      if (mounted) {
        _controller.forward(from: 0.0);
        Timer(animationDuration, () {
          if (mounted) {
            _controller.stop();
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<TaskModel>>(context);
    final event = Provider.of<HomeController>(context, listen: false);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    final bilingual = AppLocalizations.of(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: theme.scaffoldBackgroundColor, // Android saja
          systemNavigationBarColor: theme.scaffoldBackgroundColor),
    );
    return Consumer<HomeController>(builder: (context, value, child) {
      return CupertinoTabScaffold(
        controller: IosDashBoard.tabController,
        backgroundColor: CupertinoColors.systemGroupedBackground,
        tabBar: CupertinoTabBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          onTap: (value) {
            if (value == 1) {
              Provider.of<CreateRequestController>(context, listen: false)
                  .clearVar();
              IosDashBoard.tabController.index = 0;
              showDepartementDialog(context);
            } else {
              event.selectScreens(value, IosDashBoard.tabController);
            }
          },
          currentIndex: IosDashBoard.tabController.index,
          activeColor: CupertinoColors.activeBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.app_badge_fill,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              icon: Icon(CupertinoIcons.app_badge,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              label: bilingual!.request,
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.add_circled_solid,
                  color: CupertinoColors.systemRed,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              icon: Icon(CupertinoIcons.add_circled_solid,
                  color: CupertinoColors.systemRed,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              label: bilingual.createRequest,
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.archivebox_fill,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              icon: Icon(CupertinoIcons.archivebox,
                  size:
                      Platform.isAndroid ? 20.sp : const IconThemeData().size),
              label: 'Lost And Found',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          if (index == 2) {
            return LostAndFound(
              searchText: searchInput,
            );
          }
          // return IosProfile(departments: departments);
          return DashboardTask(
              scrollController: _scrollController,
              theme: theme,
              fullWidth: fullWidth,
              maxWidth: maxWidth,
              searchInput: searchInput,
              event: event,
              cUser: cUser,
              tasks: tasks,
              controller: _controller,
              colorAnimation: _colorAnimation);
        },
      );
    });
  }
}

class DashboardTask extends StatefulWidget {
  const DashboardTask({
    super.key,
    required ScrollController scrollController,
    required this.theme,
    required this.fullWidth,
    required this.maxWidth,
    required this.searchInput,
    required this.event,
    required this.cUser,
    required this.tasks,
    required AnimationController controller,
    required Animation<Color?> colorAnimation,
  })  : _scrollController = scrollController,
        _controller = controller,
        _colorAnimation = colorAnimation;

  final ScrollController _scrollController;
  final ThemeData theme;
  final double fullWidth;
  final double maxWidth;
  final TextEditingController searchInput;
  final HomeController event;
  final CUser cUser;
  final List<TaskModel> tasks;
  final AnimationController _controller;
  final Animation<Color?> _colorAnimation;

  @override
  State<DashboardTask> createState() => _DashboardTaskState();
}

class _DashboardTaskState extends State<DashboardTask> {
  @override
  Widget build(BuildContext context) {
    final bilingual = AppLocalizations.of(context);
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    final listDept = Provider.of<List<Departement>>(context);
    double maxWidth = 500;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: theme.scaffoldBackgroundColor, // Android saja
          systemNavigationBarColor: theme.scaffoldBackgroundColor),
    );
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        controller: widget._scrollController,
        anchor: 0.05,
        slivers: <Widget>[
          Consumer<HomeController>(builder: (context, value, child) {
            return CupertinoSliverNavigationBar(
                leading: Material(
                  color: Colors.transparent,
                  child: Text(
                      "${bilingual!.request}(${value.filteredListTasks.length})",
                      style: TextStyle(
                          fontSize: fullWidth < maxWidth ? 18.w : 18,
                          color: widget.theme.focusColor)),
                ),
                backgroundColor: widget.theme.scaffoldBackgroundColor,
                alwaysShowMiddle: false,
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      value.mineValue ? bilingual.myPost : bilingual.others,
                      style: TextStyle(
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.bold,
                          color: widget.theme.focusColor,
                          fontSize:
                              widget.fullWidth < widget.maxWidth ? 15.sp : 15),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Text(
                      value.sortByClose,
                      style: TextStyle(
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize:
                              widget.fullWidth < widget.maxWidth ? 15.sp : 15),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<GlobalFunction>(builder: (context, value, child) {
                      if (!value.hasInternetConnection) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.sp),
                          child: Icon(
                            CupertinoIcons.wifi_exclamationmark,
                            color: CupertinoColors.systemRed,
                            size: 25.sp,
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                IosProfile(departments: listDept),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        color: CupertinoColors.activeBlue,
                        size: 25.sp,
                      ),
                    ),
                  ],
                ),
                stretch: true,
                largeTitle: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.sp),
                        child: CupertinoSearchTextField(
                          autofocus: false,
                          style: TextStyle(
                              color: widget.theme.focusColor, fontSize: 14.sp),
                          controller: widget.searchInput,
                          onChanged: (value) =>
                              widget.event.getInputTextSearch(value),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                value.mineValue
                                    ? bilingual.myPost
                                    : bilingual.others,
                                style: TextStyle(
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.bold,
                                    color: widget.theme.focusColor,
                                    fontSize: widget.fullWidth < widget.maxWidth
                                        ? 25.sp
                                        : 25),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Text(
                                value.openValue
                                    ? bilingual.open
                                    : bilingual.closed,
                                style: TextStyle(
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                    fontSize: widget.fullWidth < widget.maxWidth
                                        ? 18.sp
                                        : 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    showSortingTaskCupertinoModal(context),
                                icon: const Icon(
                                  CupertinoIcons.sort_down,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ));
          }),
          SliverFillRemaining(
            fillOverscroll: true,
            child: Consumer<HomeController>(builder: (context, value, child) {
              widget.event.filteredTasks(widget.cUser, widget.tasks, listDept);
              if (value.openValue) {
                value.filteredListTasks.sort(
                  (a, b) => b.time!.compareTo(a.time!),
                );
              }
              return AutomaticAnimatedList<TaskModel>(
                shrinkWrap: true,
                controller: widget._scrollController,
                padding: const EdgeInsets.only(top: 8.0),
                items: value.filteredListTasks,
                keyingFunction: (TaskModel item) => Key(item.id!),
                insertDuration: const Duration(milliseconds: 300),
                removeDuration: const Duration(milliseconds: 300),
                itemBuilder: (context, task, animation) {
                  if (task.title!
                      .toLowerCase()
                      .contains(value.textInput.toLowerCase())) {
                    return FadeTransition(
                      opacity: animation,
                      key: Key(task.id!),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn,
                        ),
                        child: AnimatedBuilder(
                            animation: widget._controller,
                            builder: (context, child) => IosCardRequest(
                                  listdDepartement: listDept,
                                  data: task,
                                  animationColor: widget._colorAnimation.value,
                                  listImage: task.image!,
                                  listRequest: value.filteredListTasks,
                                )),
                      ),
                    );
                  }
                  if (task.sender!
                      .toLowerCase()
                      .contains(value.textInput.toLowerCase())) {
                    return FadeTransition(
                      opacity: animation,
                      key: Key(task.id!),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn,
                        ),
                        child: AnimatedBuilder(
                            animation: widget._controller,
                            builder: (context, child) => IosCardRequest(
                                  listdDepartement: listDept,
                                  data: task,
                                  animationColor: widget._colorAnimation.value,
                                  listImage: task.image!,
                                  listRequest: value.filteredListTasks,
                                )),
                      ),
                    );
                  }
                  if (task.location!
                      .toLowerCase()
                      .contains(value.textInput.toLowerCase())) {
                    return FadeTransition(
                      opacity: animation,
                      key: Key(task.id!),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn,
                        ),
                        child: AnimatedBuilder(
                            animation: widget._controller,
                            builder: (context, child) => IosCardRequest(
                                  listdDepartement: listDept,
                                  data: task,
                                  animationColor: widget._colorAnimation.value,
                                  listImage: task.image!,
                                  listRequest: value.filteredListTasks,
                                )),
                      ),
                    );
                  }
                  if (task.receiver!
                      .toLowerCase()
                      .contains(value.textInput.toLowerCase())) {
                    return FadeTransition(
                      opacity: animation,
                      key: Key(task.id!),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn,
                        ),
                        child: AnimatedBuilder(
                            animation: widget._controller,
                            builder: (context, child) => IosCardRequest(
                                  listdDepartement: listDept,
                                  data: task,
                                  animationColor: widget._colorAnimation.value,
                                  listImage: task.image!,
                                  listRequest: value.filteredListTasks,
                                )),
                      ),
                    );
                  }
                  if (value.textInput.isEmpty) {
                    return FadeTransition(
                      opacity: animation,
                      key: Key(task.id!),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn,
                        ),
                        child: AnimatedBuilder(
                            animation: widget._controller,
                            builder: (context, child) => IosCardRequest(
                                  listdDepartement: listDept,
                                  data: task,
                                  animationColor: widget._colorAnimation.value,
                                  listImage: task.image!,
                                  listRequest: value.filteredListTasks,
                                )),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              );
            }),
          )
        ],
        // ignore: prefer_const_constructors
      ),
    );
  }
}
