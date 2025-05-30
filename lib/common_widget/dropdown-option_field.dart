import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

class DropdownOptionField extends StatelessWidget {
  final List<String> listOption;
  static OverlayEntry? overlayEntry;
  final TextEditingController search;
  final GlobalKey globalKey;
  final String value;
  final String hintText;
  final TextStyle? textStyle;
  final IconData? iconData;
  final void Function()? onCancel;
  final void Function(String value, int index)? onItemSelected;
  final void Function(String)? onChanged;

  const DropdownOptionField({
    super.key,
    required this.listOption,
    required this.search,
    required this.globalKey,
    required this.value,
    this.textStyle = const TextStyle(fontSize: 16),
    this.onChanged,
    this.iconData,
    this.onItemSelected,
    this.hintText = "Search",
    this.onCancel,
  });

  static void hidePopup(BuildContext context) {
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
    DropdownOptionField.overlayEntry?.remove();
    DropdownOptionField.overlayEntry = null;
    provider.getPop(true);
  }

  void popUpOption({
    required BuildContext context,
    required Offset position,
    double? widht = 200,
  }) {
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
    if (DropdownOptionField.overlayEntry != null) {
      hidePopup(context); // Tutup popup sebelumnya kalau ada!
    } else {
      provider.getPop(false);
      DropdownOptionField.overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: 0,
          right: 0,
          top: position.dy + 43.sp,
          child: Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, setStatePopup) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 8.sp),
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                  ),
                  child: Consumer<CreateRequestController>(
                    builder: (context, value, child) {
                      // Filter list
                      final filteredList = listOption
                          .where((item) => item
                              .toLowerCase()
                              .contains(value.keywords.toLowerCase()))
                          .toList();

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.sp),
                            child: CupertinoSearchTextField(
                              controller: search,
                              autofocus: true,
                              onChanged: onChanged,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // ⬇️ Scrollable list dengan tinggi otomatis
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 300.h),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final itemList = filteredList[index];
                                return Container(
                                    color: Colors.white,
                                    // height: 25.h,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            alignment: Alignment.centerLeft,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0))),
                                        onPressed: () {
                                          hidePopup(context);
                                          if (onItemSelected != null) {
                                            onItemSelected!(itemList, index);
                                          }
                                        },
                                        child: Text(
                                          itemList,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )));
                              },
                            ),
                          ),

                          SizedBox(height: 10.h),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Tampilkan popup ke layar
      Overlay.of(context).insert(DropdownOptionField.overlayEntry!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: globalKey,
      onTap: () {
        final RenderBox renderBox =
            globalKey.currentContext!.findRenderObject() as RenderBox;
        final Offset position = renderBox.localToGlobal(Offset.zero);
        popUpOption(context: context, position: position);
      },
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 40.sp,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.isEmpty ? hintText : value,
                  style: textStyle,
                ),
              ),
              if (value.isNotEmpty)
                InkWell(
                  onTap: onCancel,
                  child: Icon(
                    CupertinoIcons.xmark_circle,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
