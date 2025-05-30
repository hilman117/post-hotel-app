import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/models/popular_model.dart';
import 'data_table_widget.dart';

class ColumnFourRows extends StatelessWidget {
  const ColumnFourRows({
    super.key,
    required this.theme,
    required this.data,
    required this.label,
  });

  final ThemeData theme;
  final List<PopularModel> data;
  final List<String> label;

  @override
  Widget build(BuildContext context) {
    List<PopularModel> listFiltered =
        data.where((element) => element.total != 0).toList();
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return DataTableWidget(
      theme: theme,
      label: label.first,
      labelColumn: label,
      listDataRows: List.generate(listFiltered.length, (index) {
        PopularModel dataIndex = listFiltered[index];
        return DataRow(
          cells: [
            DataCell(
              Text(
                dataIndex.itemName ?? '',
                style: TextStyle(
                  fontSize: fullWidth < maxWidth ? 16.sp : 16,
                  fontWeight: FontWeight.normal,
                  color: theme.focusColor.withOpacity(0.5),
                ),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                child: Text(
                  dataIndex.total.toString(),
                  style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    fontWeight: FontWeight.normal,
                    color: theme.focusColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                child: Text(
                  dataIndex.closed.toString(),
                  style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    fontWeight: FontWeight.normal,
                    color: theme.focusColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                child: Text(
                  dataIndex.resolutionTime.toString(),
                  style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    fontWeight: FontWeight.normal,
                    color: theme.focusColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                child: Text(
                  dataIndex.ratePercent.toString(),
                  style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    fontWeight: FontWeight.normal,
                    color: theme.focusColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
