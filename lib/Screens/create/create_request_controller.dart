// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_app/Screens/example/general_widget.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_post_data.dart';
import 'package:post_app/global_function.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/main.dart';
import 'package:post_app/models/titles_model.dart';
import 'package:post_app/variable.dart';

import '../../controller/c_user.dart';
import '../../models/departement_model.dart';
import '../../service/theme.dart';
import '../edit_photo_room/edit_photo_room.dart';
import '../sign_up/signup.dart';

class CreateRequestController with ChangeNotifier {
  final user = Get.put(CUser());
  final db = FirebasePostData();
  bool _isCreateRequest = true;
  bool get isCreateRequest => _isCreateRequest;
  bool _isLfReport = false;
  bool get isLfReport => _isLfReport;
  void checkBoxCreateRequest() {
    _isCreateRequest = true;
    _isLfReport = false;
    // _isLoading = false;
    notifyListeners();
  }

  bool canPop = true;

  void getPop(bool value) {
    canPop = value;
    notifyListeners();
  }

  void checkBoxLf() {
    _isCreateRequest = false;
    _isLfReport = true;
    // _isLoading = false;
    notifyListeners();
  }

  final List<String> _departments = [];
  List<String> get departments => _departments;
  Future<void> getDeptartement() async {
    _departments.clear();
    var result = await FirebaseFirestore.instance
        .collection("users")
        .where("hotelid", isEqualTo: user.data.hotelid)
        .get();
    Set listDepartement =
        result.docs.map((e) => e.data()['department']).toSet();
    List<String> list = List.castFrom(listDepartement.toList());
    _departments.addAll(list);
    notifyListeners();
  }

  String _selectedDept = 'Choose Department';
  String get selectedDept => _selectedDept;
  void selectDept(String dept) {
    _selectedDept = dept;
    selectedTitle = '';
    selectedLocatioin = "";
    descriptionController.clear();

    _imageUrl.clear();
    print(_imageUrl.toString());
    print(_selectedDept);
    // notifyListeners();
  }

  void clearData() {
    selectedLocatioin = "";
    selectedTitle = '';

    _imageUrl.clear();
    notifyListeners();
    print(_imageUrl.toString());
  }

  // List<String> _title = [];
  // List<String> get title => _title;
  String selectedTitle = '';

  void selectTitle(String title) {
    selectedTitle = title;
    _searchtitle.clear();
    print(selectedTitle);
    notifyListeners();
  }

  void clearTitle() {
    selectedTitle = "";
    _searchtitle.clear();
    notifyListeners();
  }

  final TextEditingController _searchtitle = TextEditingController();
  TextEditingController get searchtitle => _searchtitle;
  void getTitle(String value) {
    keywords = value;
    notifyListeners();
  }

  void clearSearchTitle() {
    keywords = '';
    notifyListeners();
  }

  String keywords = "";
  String selectedLocatioin = "";
  Future searchLocation(List<String> location, String param) async {
    List<String> result = location
        .where((element) => element.toLowerCase().contains(param.toLowerCase()))
        .toList();
    keywords = param;
    notifyListeners();
    return result;
  }

  void selectLocation(String location) {
    selectedLocatioin = location;
    notifyListeners();
  }

  void clearLocation() {
    selectedLocatioin = "";
    notifyListeners();
  }

  String _newDate = '';
  String get newDate => _newDate;
  String _datePicked = '';
  String get datePicked => _datePicked;
  DateTime? _setDate;
  DateTime? get setDate => _setDate;
  DateTime? resultDate;
  Future<void> dateTimPicker(BuildContext context) async {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final bilingual = AppLocalizations.of(context);
    if (hour.isEmpty && minute.isEmpty) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(bilingual!.setTimeIsEmpty),
            content: Text(bilingual.unableToAddTheDateWithoutTime),
            actions: [
              CupertinoButton(
                child: Text(bilingual.close),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    } else {
      await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: fullWidth < maxWidth ? 200.h : 200,
              width: double.infinity,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                backgroundColor: theme.scaffoldBackgroundColor,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  _setDate = DateTime(newDate.year, newDate.month, newDate.day);
                  _datePicked = _setDate!.toString();
                  _newDate = DateFormat('EEEE, d MMM').format(_setDate!);
                  changeDate(_datePicked);
                  print(_setDate);
                  notifyListeners();
                },
              ),
            );
          });
    }
  }

  void cancelButton(String oldDate, String oldTime) {
    _datePicked = oldDate;
    _selectedTime = oldTime;
    notifyListeners();
  }

  void changeDate(String dateChange) {
    _datePicked = dateChange;
    notifyListeners();
  }

  String _newTime = '';
  String get newTime => _newTime;
  void clearTime() {
    _datePicked = "";
    _newDate = '';
    _newTime = '';
    hour = "";
    minute = "";
    notifyListeners();
  }

  void clearDate() {
    _setDate = null;
    _datePicked = "";
    _newDate = '';
    notifyListeners();
  }

  String _selectedTime = '';
  String get selectedTime => _selectedTime;
  TimeOfDay? currentTime;
  String hour = "";
  String minute = "";
  Future<Future> timePIcker(BuildContext context, AppLocalizations app) async {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => SizedBox(
              width: double.infinity,
              height: fullWidth < maxWidth ? 200.h : 200,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now().subtract(const Duration(hours: 24)),
                backgroundColor: theme.scaffoldBackgroundColor,
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime dateTime) {
                  TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
                  currentTime = timeOfDay;
                  currentTime = timeOfDay;

                  // Format hour and minute with leading zeros if necessary
                  hour = timeOfDay.hour.toString().padLeft(2, '0');
                  minute = timeOfDay.minute.toString().padLeft(2, '0');

                  // Set _selectedTime in the desired format
                  _selectedTime = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          timeOfDay.hour,
                          timeOfDay.minute)
                      .toUtc()
                      .toIso8601String();
                  _newTime = timeOfDay.format(context);
                  print(_newTime);
                  changeTime(_selectedTime);
                  print(currentTime!.hour);
                  print(currentTime!.minute);
                },
              ),
            ));
  }

  void changeTime(String timeChange) {
    _selectedTime = timeChange;
    notifyListeners();
  }

  void clearSchedule() {
    _setDate = null;
    currentTime = null;
    _datePicked = '';
    _selectedTime = '';
    _newDate = '';
    _newTime = '';
    hour = "";
    minute = "";
    notifyListeners();
  }

  final List<XFile?> _imageList = [];
  List<XFile?> get imagesList => _imageList;
  XFile? _fromCamera;
  XFile? get fromCamera => _fromCamera;
  final List<String> _imageUrl = [];
  List<String> get imageUrl => _imageUrl;
  String imageName = '';
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isLoadImage = false;

  Future<void> selectImage(BuildContext context, ImageSource source) async {
    isLoadImage = true;
    notifyListeners();
    try {
      final navigator = Navigator.of(context);
      List<XFile?> selectedImage =
          await _picker.pickMultiImage(imageQuality: 30);
      if (selectedImage.isNotEmpty) {
        if (selectedImage.length == 1) {
          FocusNode().unfocus();
          Uint8List imageToEdit = await selectedImage[0]!.readAsBytes();
          navigator.push(
            MaterialPageRoute(
              builder: (context) {
                return EditPhotoRoom(imageToEdit: imageToEdit);
              },
            ),
          );
        } else {
          _imageList.addAll(selectedImage);
        }

        // ignore: use_build_context_synchronously
        // Navigator.pop(context);
      }
    } finally {
      isLoadImage = false;
      notifyListeners();
    }
  }

  Future<void> selectFromCamera(BuildContext context) async {
    final navigator = Navigator.of(context);
    _fromCamera =
        await _picker.pickImage(imageQuality: 30, source: ImageSource.camera);
    if (_fromCamera != null) {
      FocusNode().unfocus();
      Uint8List imageToEdit = await _fromCamera!.readAsBytes();
      navigator.push(
        MaterialPageRoute(
          builder: (context) => EditPhotoRoom(imageToEdit: imageToEdit),
        ),
      );
    }
    notifyListeners();
  }

  Future<XFile> saveImageToTemp(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    final file = File(
        '${tempDir.path}/post_image_edited_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(data);
    return XFile(file.path);
  }

  void addToSelectedImageList(BuildContext context, Uint8List image) async {
    XFile file = await saveImageToTemp(image);
    _imageList.add(file);
    notifyListeners();
    Navigator.pop(context);
  }

  void restartVariable() {
    _fromCamera = null;
    imageName = '';
    imageUrl.clear();
    _imageList.clear();
    nameItem.clear();
    _isLfReport = false;
    _isCreateRequest = true;
    notifyListeners();
  }

  String nameItemFound = '';
  void listenNameItemtyping(String itemName) {
    nameItemFound = itemName;
    notifyListeners();
  }

  void clearNameItemtyping() {
    nameItemFound = "";
    nameItem.clear();
    notifyListeners();
  }

  void removeSingleImage(int index) {
    _imageList.removeAt(index);
    imageName = '';
    notifyListeners();
  }

  //to update how many requests are made by this user
  int _createTotal = 0;
  int get createTotal => _createTotal;
  Future<void> getTotalCreate() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();
    _createTotal = userDoc['createRequest'];
    print('this is total request are accepted by this user $_createTotal');
    notifyListeners();
  }

  int? _newTotal;
  int? get newTotal => _newTotal;
  void addNewRequestTotal(BuildContext context, int addOne) {
    if (_newTotal == null) {
      _newTotal = _createTotal + addOne;
      notifyListeners();
    } else {
      _newTotal = (newTotal! + addOne);
      notifyListeners();
    }
  }

  TextEditingController descriptionTask = TextEditingController();
  Future<void> tasks(
      String imageSender,
      BuildContext context,
      String hotelId,
      String userId,
      TextEditingController controller,
      String senderName,
      String senderDept,
      String senderEmail,
      String title,
      Departement sendTo,
      List<String> listLocation,
      List<Departement> listDept) async {
    DateTime now = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(now);
    // try {
    final application = AppLocalizations.of(context);
    if (selectedLocatioin.isEmpty) {
      Fluttertoast.showToast(
          msg: application!.chooseSpecificLocation,
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (selectedTitle.isEmpty) {
      Fluttertoast.showToast(
          msg: application!.titleIsEmpty,
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (!listLocation.contains(selectedLocatioin)) {
      Fluttertoast.showToast(
          msg: "Location not registered",
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (!sendTo.title!.contains(selectedTitle)) {
      Fluttertoast.showToast(
          msg: "Title not registered",
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (_setDate != null && _selectedTime.isEmpty) {
      Fluttertoast.showToast(
          msg: "No time was set",
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else {
      loading(context);
      String idTask = GlobalFunction().generateUniqueId().toString();
      String topic = "";
      List<String> listReceiverName = [];
      listReceiverName.clear();
      // topic = "";
      List<Map<String, dynamic>> receivingUser = sendTo.receivingUser!;
      for (var i = 0; i < receivingUser.length; i++) {
        if (receivingUser[i]["triggeredMinute"] == "0") {
          topic = receivingUser[i]["id"];
          listReceiverName
              .addAll(List<String>.from(receivingUser[i]["receiver"]));
        }
      }
      if (_imageList.isNotEmpty) {
        List<Future<void>> uploadTasks = [];

        for (int i = 0; i < _imageList.length; i++) {
          final file = File(_imageList[i]!.path);
          final imageExtension = file.path.split('.').last;
          final ref = FirebaseStorage.instance.ref(
              "$hotelId/${userId}_${DateTime.now().millisecondsSinceEpoch}.$imageExtension");

          // Tambahkan setiap proses upload ke dalam list Future
          uploadTasks.add(ref.putFile(file).then((_) async {
            final downloadUrl = await ref.getDownloadURL();
            _imageUrl.add(downloadUrl);
          }));
        }

        // Tunggu semua proses upload selesai
        await Future.wait(uploadTasks);
        //upload task with images
        await db.createTask(
          registeredTask: [],
          context: context,
          hotelName: hotelId,
          assigned: listReceiverName,
          image: _imageUrl,
          description: controller.text,
          emailReceiver: "",
          emailSender: senderEmail,
          from: senderDept,
          id: idTask,
          location: selectedLocatioin,
          positionSender: user.data.position!,
          profileImageSender: user.data.profileImage!,
          receiver: "",
          sendTo: sendTo.departement!,
          sender: user.data.name!,
          setDate: _setDate != null ? _setDate!.toUtc().toIso8601String() : "",
          setTime: _selectedTime,
          time: timestamp,
          closeTime: "",
          colorUser: user.data.userColor!,
          title: selectedTitle,
          status: "New",
          iconDepartement: sendTo.departementIcon!,
          topic: topic,
          resolusi: "",
        );

        if (controller.text.isNotEmpty) {
          Notif().sendNotifToTopic(
              topic.toLowerCase(),
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: $selectedLocatioin - "$selectedTitle"\n${controller.text}',
              idTask,
              "tasks",
              imageUrl.first,
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
          Notif().sendNotifToTopic(
              "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${sendTo.departement!.removeAllWhitespace.toLowerCase()}",
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: $selectedLocatioin - "$selectedTitle"\n${controller.text}',
              idTask,
              "tasks",
              imageUrl.first,
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
        } else {
          Notif().sendNotifToTopic(
              topic.toLowerCase(),
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: $selectedLocatioin - "$selectedTitle"',
              idTask,
              "tasks",
              imageUrl.first,
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
          //mengirim notif ke token admin yang login di web
          Notif().sendNotifToTopic(
              "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${sendTo.departement!.removeAllWhitespace.toLowerCase()}",
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: $selectedLocatioin - "$selectedTitle"',
              imageUrl.first,
              idTask,
              "tasks",
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
        }
        Navigator.of(context).pop();
        controller.clear();
        _setDate = null;
        _selectedTime = "";
      } else {
        //upload task without images
        await db.createTask(
            topic: topic,
            context: context,
            hotelName: hotelId,
            assigned: listReceiverName,
            image: [],
            description: controller.text,
            emailReceiver: "",
            emailSender: senderEmail,
            from: senderDept,
            id: idTask,
            location: selectedLocatioin,
            positionSender: user.data.position!,
            profileImageSender: user.data.profileImage!,
            receiver: "",
            sendTo: sendTo.departement!,
            sender: user.data.name!,
            setDate:
                _setDate != null ? _setDate!.toUtc().toIso8601String() : "",
            setTime: _selectedTime,
            time: timestamp,
            closeTime: "",
            colorUser: user.data.userColor!,
            title: selectedTitle,
            status: "New",
            iconDepartement: sendTo.departementIcon!,
            resolusi: "",
            registeredTask: []);
        if (controller.text.isNotEmpty) {
          Notif().sendNotifToTopic(
              topic.toLowerCase(),
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: "$selectedLocatioin" - "$selectedTitle"\n ${controller.text}',
              idTask,
              "tasks",
              "",
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
          Notif().sendNotifToTopic(
              "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${sendTo.departement!.removeAllWhitespace.toLowerCase()}",
              "New ${sendTo.departement}",
              '${user.data.name} has sent new request: "$selectedLocatioin" - "$selectedTitle"\n ${controller.text}',
              "",
              idTask,
              "tasks",
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
        } else {
          Notif().sendNotifToTopic(
              topic.toLowerCase(),
              "New ${sendTo.departement}",
              "${user.data.name} has sent new request: $selectedLocatioin - $selectedTitle",
              idTask,
              "tasks",
              "",
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
          Notif().sendNotifToTopic(
              "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${sendTo.departement!.removeAllWhitespace.toLowerCase()}",
              "New ${sendTo.departement}",
              "${user.data.name} has sent new request: $selectedLocatioin - $selectedTitle",
              idTask,
              "tasks",
              "",
              "New",
              "New",
              selectedLocatioin,
              sendTo.departement!,
              user.data.hotel!);
        }
        Notif().saveTopic(idTask);
        controller.clear();
        _setDate = null;
        _selectedTime = "";
      }

      // ignore: use_build_context_synchronously
      Get.back();
      _searchtitle.clear();
      notifyListeners();
    }
  }

  bool isValueable = false;

  void valueableItemOrNot(bool value) {
    isValueable = value;
    notifyListeners();
  }

  String emailAdmin = '';
  TextEditingController nameItem = TextEditingController();
  Future lfReport(
      BuildContext context,
      String deptStorage,
      String hotelId,
      String userId,
      TextEditingController controller,
      String senderName,
      String senderEmail,
      String location,
      String description,
      List<Departement> listDept) async {
    DateTime now = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(now);
    final applcation = AppLocalizations.of(context);
    String idTask = GlobalFunction().generateUniqueId().toString();
    Departement lfDept =
        listDept.singleWhere((element) => element.departement == deptStorage);
    if (selectedLocatioin.isEmpty) {
      Fluttertoast.showToast(
          msg: applcation!.chooseSpecificLocation,
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (nameItem.text.isEmpty) {
      Fluttertoast.showToast(
          msg: applcation!.nameOfItemShouldBeFilled,
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else if (_imageList.isEmpty) {
      Fluttertoast.showToast(
          msg: applcation!.shouldAttachAnImage,
          backgroundColor: Colors.white,
          textColor: mainColor);
    } else {
      try {
        loading(context);
        String token = box!.get("token");
        String senderToken = selectedDept == cUser.data.department ? "" : token;
        if (_imageList.isNotEmpty) {
          List.generate(_imageList.length, (index) async {
            String imageExtension = imageName.split('.').last;
            final ref = FirebaseStorage.instance.ref(
                "$hotelId/${userId + DateTime.now().toString()}.$imageExtension");
            await ref.putFile(File(_imageList[index]!.path));
            await ref.getDownloadURL().then((value) async {
              _imageUrl.add(value);
              await db.createLfReport(
                  isValueable: isValueable,
                  context: context,
                  hotelName: hotelId,
                  assigned: deptStorage,
                  image: _imageUrl,
                  description: description,
                  emailReceiver: "",
                  emailSender: senderEmail,
                  from: user.data.department!,
                  id: idTask,
                  location: selectedLocatioin,
                  positionSender: user.data.position!,
                  profileImageSender: user.data.profileImage!,
                  receiver: "",
                  sendTo: deptStorage,
                  sender: user.data.name!,
                  setDate: "",
                  setTime: "",
                  time: timestamp,
                  closeTime: "",
                  colorUser: user.data.userColor!,
                  title: nameItem.text,
                  status: "New",
                  iconDepartement: lfDept.departementIcon!,
                  senderToken: senderToken);
            });
          });
        }
        String admnToken = lfDept.adminToken!;
        if (admnToken.isNotEmpty) {
          Notif().sendNotifToToken(
              admnToken,
              "NEW lost and found",
              "${nameItem.text} founded at $selectedLocatioin",
              "",
              idTask,
              collectionlf,
              "New",
              "New");
        }

        Notif().saveTopic(idTask);
        notifyListeners();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        Get.back();
        controller.clear();
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(
            backgroundColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            textColor: mainColor,
            msg: applcation!.upsSomethingWrong);
        // print(e);
      }
    }
  }

  void clearVar() {
    nameItem.clear();
    _imageList.clear();
    _imageUrl.clear();
    isValueable = false;
    notifyListeners();
  }

  String text = "";
  String selectedOption(TitlesModel value) {
    text = value.title!;
    notifyListeners();
    return text;
  }

  Color colorOfMatchFont(ThemeData theme, String indexOfWord, String keyWords) {
    if (keyWords.toLowerCase().contains(indexOfWord.toLowerCase())) {
      return Colors.blue;
    }
    return theme.focusColor;
  }
}
