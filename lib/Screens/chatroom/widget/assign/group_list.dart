import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/departement_model.dart';
import '../../chatroom_controller.dart';

Widget listOfGroup(Departement dept, int index) {
  return StatefulBuilder(
    builder: (context, setState) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.white),
              top: BorderSide(width: 0.5, color: Colors.white))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dept.departement!,
            style: const TextStyle(color: Colors.grey, fontFamily: "Roboto"),
          ),
          Consumer<ChatRoomController>(
              builder: (context, value, child) => Switch(
                    activeColor: Colors.blue,
                    activeTrackColor: const Color(0xff007dff),
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      Provider.of<ChatRoomController>(context, listen: false)
                          .selectFucntionGroup(value, index);
                    },
                    value: value.boolLlistGroup![index],
                  )),
        ],
      ),
    ),
  );
}
