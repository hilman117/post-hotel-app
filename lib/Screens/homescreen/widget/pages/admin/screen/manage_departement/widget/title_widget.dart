import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/common_widget/form_create_account.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../common_widget/show_dialog.dart';
import '../../../../../../../../models/departement_model.dart';
import '../../../admin_controller.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.event,
    required this.theme,
    required this.departement,
  });

  final AdminController event;
  final ThemeData theme;
  final Departement departement;

  @override
  Widget build(BuildContext context) {
    final user = Get.put(CUser());
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    bool isDark = theme.brightness == Brightness.dark;
    return Consumer<AdminController>(
        builder: (context, value, child) => Card(
              color: theme.cardColor,
              elevation: isDark ? 0 : 1,
              margin: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
              child: Padding(
                padding: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: fullWidth < maxWidth ? 10.sp : 10),
                      child: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 13.sp : 13,
                            color: theme.focusColor),
                      ),
                    ),
                    SizedBox(
                      height: fullWidth < maxWidth ? 10.h : 10,
                    ),
                    ExpansionTile(
                      initiallyExpanded: value.isCollapseTitle,
                      onExpansionChanged: (value) {
                        event.colapsingPanel(valueTitle: value);
                      },
                      trailing: Padding(
                        padding: EdgeInsets.only(
                            left: fullWidth < maxWidth ? 10.sp : 10,
                            right: fullWidth < maxWidth ? 20.sp : 20),
                        child: Tooltip(
                          message: "Add title",
                          child: CircleAvatar(
                            backgroundColor: theme.scaffoldBackgroundColor,
                            child: Icon(
                              value.isCollapseTitle
                                  ? Icons.close_outlined
                                  : Icons.add,
                              color: theme.focusColor,
                            ),
                          ),
                        ),
                      ),
                      tilePadding: EdgeInsets.zero,
                      title: Container(
                        height: fullWidth < maxWidth ? 35.h : 35,
                        padding: EdgeInsets.symmetric(
                            horizontal: fullWidth < maxWidth ? 10.sp : 10),
                        child: SearchBar(
                          elevation: WidgetStateProperty.resolveWith(
                              (states) =>
                                  ThemeMode.system == ThemeMode.dark ? 0 : 1),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              // Warna saat tombol dalam keadaan normal atau lainnya.
                              return theme.scaffoldBackgroundColor;
                            },
                          ),
                          controller: value.titleController,
                          hintText: "Search title",
                          hintStyle: WidgetStateProperty.resolveWith(
                              (states) => const TextStyle(color: Colors.grey)),
                          onChanged: (value) {
                            event.searching(keywords: value);
                          },
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: fullWidth < maxWidth ? 10.h : 10,
                        ),
                        FormCreateAcount(
                            typingFunction: (val) {
                              event.input(value: val);
                            },
                            label: "Input title",
                            textContronller: value.inputNewTitle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                                onPressed: value.newTitle.isEmpty
                                    ? null
                                    : () => event.addTitle(
                                        context,
                                        user.data.hotel!,
                                        departement.departement!),
                                child: const Text("Save"))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: fullWidth < maxWidth ? 10.h : 10,
                    ),
                    AnimatedContainer(
                      height: fullWidth < maxWidth ? 300.h : 300,
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: departement.title!.length,
                              itemBuilder: (context, index) {
                                String title = departement.title![index];
                                if (departement.title![index]
                                    .toLowerCase()
                                    .contains(
                                        value.searchTitle.toLowerCase())) {
                                  return ListTile(
                                    trailing: IconButton(
                                        splashRadius:
                                            fullWidth < maxWidth ? 20.r : 20,
                                        onPressed: () => ShowDialog().confirmDialog(
                                            context,
                                            "Are you sure to delete '$title' from list?",
                                            () => event.deleteTitle(
                                                context,
                                                user.data.hotel!,
                                                departement.departement!,
                                                departement.title!,
                                                index)),
                                        icon: Icon(
                                          Icons.delete,
                                          color: theme.focusColor,
                                        )),
                                    title: Text(
                                      title,
                                      style: TextStyle(
                                          fontSize:
                                              fullWidth < maxWidth ? 15.sp : 15,
                                          color: theme.focusColor),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              })),
                    ),
                  ],
                ),
              ),
            ));
  }
}
