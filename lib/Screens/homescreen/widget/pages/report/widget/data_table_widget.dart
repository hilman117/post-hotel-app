import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/custom/custom_scroll_behavior.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({
    super.key,
    required this.theme,
    required this.label,
    required this.labelColumn,
    required this.listDataRows,
  });

  final ThemeData theme;
  final String label;
  final List<String> labelColumn;
  final List<DataRow> listDataRows;

  @override
  // ignore: library_private_types_in_public_api
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 10.sp : 10),
      height: fullWidth < maxWidth ? 400.h : 400,
      decoration:
          BoxDecoration(border: Border.all(color: widget.theme.focusColor)),
      child: Column(
        children: [
          //label
          Container(
            height: fullWidth < maxWidth ? 40.h : 40,
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: widget.theme.focusColor.withOpacity(0.5)),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: fullWidth < maxWidth ? 16.sp : 16,
                fontWeight: FontWeight.bold,
                color: widget.theme.focusColor.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior()
                  .copyWith(overscroll: false, scrollbars: true),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _verticalController,
                  child: DataTable(
                      showCheckboxColumn: false,
                      columns: List.generate(
                        widget.labelColumn.length,
                        (index) => DataColumn(
                          label: Text(
                            widget.labelColumn[index].toUpperCase(),
                            style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 16.sp : 16,
                              fontWeight: FontWeight.bold,
                              color: widget.theme.focusColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      rows: widget.listDataRows),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
