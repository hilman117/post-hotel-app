import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/register_new_hotel/controller_register_hotel.dart';
import 'package:provider/provider.dart';

class RegisterNewHotel extends StatefulWidget {
  const RegisterNewHotel({super.key});

  @override
  State<RegisterNewHotel> createState() => _RegisterNewHotelState();
}

class _RegisterNewHotelState extends State<RegisterNewHotel> {
  TextEditingController hotelName = TextEditingController();
  TextEditingController emailDomain = TextEditingController();
  TextEditingController adminName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController deptName = TextEditingController();
  TextEditingController hotelId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<ControllerRegisterHotel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: false,
        title: const Text(
          "Register New Hotel",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          FormRegisterNew(
            label: 'Hotel Name',
            icon: Icons.hotel,
            controller: hotelName,
          ),
          FormRegisterNew(
            label: 'ID Hotel',
            icon: Icons.no_accounts,
            controller: hotelId,
          ),
          FormRegisterNew(
            onChanged: (value) => controller.hotelDomain(value),
            label: 'Email Domain',
            icon: Icons.domain,
            controller: emailDomain,
          ),
          FormRegisterNew(
            label: 'Master Admin Name',
            icon: Icons.admin_panel_settings_sharp,
            controller: adminName,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: FormRegisterNew(
                    label: 'Master Admin Email',
                    icon: Icons.alternate_email,
                    controller: email,
                  ),
                ),
                Consumer<ControllerRegisterHotel>(
                    builder: (context, value, child) {
                  return Text(value.domainHotelEmail);
                }),
                SizedBox(
                  width: 16.w,
                )
              ],
            ),
          ),
          FormRegisterNew(
            label: 'Position',
            icon: Icons.account_tree,
            controller: position,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: FormRegisterNew(
                    label: 'Department Name',
                    icon: Icons.group,
                    controller: deptName,
                  ),
                ),
                const Text("Icon Department"),
                Consumer<ControllerRegisterHotel>(
                    builder: (context, value, child) {
                  return IconButton(
                      onPressed: () => dialogSelectIcon(context),
                      isSelected: value.isSelected,
                      selectedIcon: Image.asset(
                        value.deptIcon,
                        height: 30.h,
                        width: 30.h,
                      ),
                      icon: Icon(
                        Icons.image,
                        size: 30.sp,
                      ));
                })
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => controller.registerNewHotel(context, hotelName,
                    emailDomain, adminName, position, email, deptName, hotelId),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

List<String> roles = ["Non-admin", "Dept. Admin", "Administrator"];

class FormRegisterNew extends StatelessWidget {
  const FormRegisterNew({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.onChanged,
  });

  final String label;
  final void Function(String)? onChanged;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
        decoration: InputDecoration(
            label: Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 15.sp,
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(label)
          ],
        )),
      ),
    );
  }
}

Future dialogSelectIcon(BuildContext context) {
  List<String> listIcon = [
    "images/Butler.png",
    "images/chef.png",
    "images/Concierge.png",
    "images/Engineering.png",
    "images/entertain-2.png",
    "images/Front Office.png",
    "images/guard.png",
    "images/Housekeeping.png",
    "images/hotel-bell.png",
    "images/hr-manager.png",
    "images/IT Support.png",
    "images/kitchen-utensils.png",
    "images/laundry.png",
    "images/Room Service.png"
  ];
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        width: 200.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Icon"),
            SizedBox(
              height: 10.h,
            ),
            Wrap(
              children: listIcon
                  .map((e) => Consumer<ControllerRegisterHotel>(
                          builder: (context, value, child) {
                        final controller = Provider.of<ControllerRegisterHotel>(
                            context,
                            listen: false);
                        return GestureDetector(
                          onTap: () => controller.selectIcon(e),
                          child: Container(
                            margin: EdgeInsets.all(2.sp),
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: value.deptIcon == e
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Image.asset(
                              e,
                              width: 30.w,
                              height: 30.h,
                            ),
                          ),
                        );
                      }))
                  .toList(),
            )
          ],
        ),
      ),
    ),
  );
}
