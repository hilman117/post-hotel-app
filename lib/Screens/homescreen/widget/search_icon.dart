import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_controller.dart';

Widget searchIcon(BuildContext context) {
  return InkWell(
    onTap: () {
      context.read<HomeController>().changeValue();
    },
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Icon(
        Icons.search,
        color: Colors.black45,
      ),
    ),
  );
}
