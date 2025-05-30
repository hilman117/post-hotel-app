import 'package:flutter/material.dart';

class StatusReport extends StatelessWidget {
  final String status;
  const StatusReport({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: 23,
      // width: 70,
      decoration: BoxDecoration(
        color: (status == 'New')
            ? Colors.red.shade50
            : (status == 'Accepted')
                ? Colors.green.shade50
                : (status == 'Claimed')
                    ? Colors.grey.shade300
                    : (status == 'Released')
                        ? Colors.blue.shade50
                        : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(
        //     color: (status == 'New')
        //         ? Colors.red.shade200
        //         : (status == 'Accepted')
        //             ? Colors.green.shade200
        //             : (status == 'Resume')
        //                 ? Colors.green.shade200
        //                 : (status == 'ESC')
        //                     ? Colors.orange.shade200
        //                     : (status == 'Close')
        //                         ? Colors.grey.shade200
        //                         : (status == 'On Hold')
        //                             ? Colors.grey.shade200
        //                             : (status == 'Assigned')
        //                                 ? Colors.blue.shade900
        //                                 : Colors.blue.shade200,
        //     width: 0.1)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          status,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 14,
            color: (status == 'New')
                ? Colors.red.shade400
                : (status == 'Accepted')
                    ? Colors.green.shade400
                    : (status == 'Claimed')
                        ? Colors.grey.shade900
                        : (status == 'Released')
                            ? Colors.blue.shade400
                            : Colors.blue.shade400,
          ),
        ),
      ),
    );
  }
}
