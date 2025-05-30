import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/models/tasks.dart';

Color primaryColor = const Color(0xff007dff);

List<Color> backgroundIcon = [
  Colors.green.shade200,
  Colors.red.shade200,
  Colors.blue.shade200,
  Colors.purple.shade200,
  Colors.orange.shade200,
  Colors.brown.shade200,
  Colors.deepPurple.shade200,
  Colors.grey,
  Colors.indigo.shade200,
  Colors.pink.shade200,
  Colors.teal.shade200,
];

Widget form(TextEditingController controller, String hintText, Icon icon,
    TextInputType textInputType) {
  return Row(
    children: [
      Flexible(
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "This Field is missing";
            } else {
              return null;
            }
          },
          textInputAction: TextInputAction.next,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: textInputType,
          decoration: InputDecoration(
              prefixIcon: icon,
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              hintText: hintText),
        ),
      ),
    ],
  );
}

class GeneralButton extends StatefulWidget {
  final String buttonName;
  final double height;
  final double widht;
  final Color primary;
  final Color colorText;
  final GestureTapCallback onPressed;
  const GeneralButton(
      {super.key,
      required this.buttonName,
      required this.height,
      required this.primary,
      required this.onPressed,
      required this.colorText,
      required this.widht});

  @override
  State<GeneralButton> createState() => _GeneralButtonState();
}

class _GeneralButtonState extends State<GeneralButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widht,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            setState(() {
              FocusScope.of(context).unfocus();
              widget.onPressed();
            });
          },
          child: Container(
              alignment: Alignment.center,
              height: widget.height,
              // width: double.infinity,
              child: Text(
                widget.buttonName,
                style: TextStyle(color: widget.colorText),
              ))),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String sendTo;
  final String senderName;
  final String positionSender;
  final String status;
  final String receiver;
  const HeaderWidget({
    super.key,
    required this.sendTo,
    required this.senderName,
    required this.positionSender,
    required this.status,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String sendKe = sendTo;
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Image.asset(
          "images/$sendTo.png",
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(senderName,
                style: const TextStyle(color: Color(0xff333333), fontSize: 15)),
            const SizedBox(
              height: 3,
            ),
            Text(
              positionSender,
              style: const TextStyle(fontSize: 13, color: Color(0xffBDBDBD)),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // StatusWidget(status: status),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 170,
              child: Flexible(
                child: Text(receiver,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 13, color: Colors.blue)),
              ),
            ),
          ],
        )
      ],
    );
  }
}

final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
// final cAccepted = Get.put(CAccepted());

void taskOption(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 80,
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Get.to(() => AddNewTask(),
                    //     transition: Transition.rightToLeft);
                  },
                  child: SizedBox(
                    height: 40,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.create,
                          color: Color(0xff007dff),
                        ),
                        SizedBox(width: 10),
                        Text("Create New Task")
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Get.to(() => LostAndFound(),
                    //     transition: Transition.rightToLeft);
                  },
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/lf.png",
                          width: 23,
                        ),
                        const SizedBox(width: 10),
                        const Text("Lost And Found Report")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// void _rotateDialog(context) {
//     showGeneralDialog(
//       context: context,
//       pageBuilder: (ctx, a1, a2) {
//         return Container();
//       },
//       transitionBuilder: (ctx, a1, a2, child) {
//         return Transform.rotate(
//           angle: math.radians(a1.value * 360),
//           child: (ctx),
//         );
//       },
//       transitionDuration: const Duration(milliseconds: 300),
//     );
//   }


