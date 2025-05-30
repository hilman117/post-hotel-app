import 'package:flutter/material.dart';
import 'package:post_app/Screens/dasboard/ios_dashboard.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:post_app/core.dart';
import 'package:post_app/global_function.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isInitialized = false;
  @override
  void initState() {
    if (box!.get('sendNotification') == null) {
      box!.putAll({'sendNotification': true});
    }
    Provider.of<HomeController>(context, listen: false).getDepartementList();
    Provider.of<HomeController>(context, listen: false).getDataHotel();
    Provider.of<SettingProvider>(context, listen: false).getOnDutyValue();
    // FirebaseMessaging.onMessage.listen(
    //   (event) {
    //     if (event.data.isNotEmpty) {
    //       NotificationController.createNewNotification(event);
    //     }
    //   },
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listDept = Provider.of<List<Departement>>(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Consumer<HomeController>(builder: (context, value, child) {
          return Stack(
            children: [
              IosDashBoard(
                list: listDept,
              ),
              if (value.isLoading)
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                )
            ],
          );
        }));
  }
}
