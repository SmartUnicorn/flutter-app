/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/constants_helper.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/catalog/sorting_data.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet(this.sort, this.onSort, {this.selected, Key? key})
      : super(key: key);
  final SortingData? selected;
  final List<SortingData>? sort;
  final ValueChanged<SortingData?> onSort;

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late String? groupValue;

  @override
  void initState() {
    if (widget.selected != null) {
      groupValue = "${widget.selected?.code}-${widget.selected?.direction}";
    } else {
      groupValue =
          "${widget.sort?.first.code}-${ConstantsHelper.directionLowToHigh}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(groupValue);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppBar(
          elevation: 0,
          title: Text(
            Utils.getStringValue(context, AppStringConstant.sortBy)
                .toUpperCase(),
            style: Theme.of(context).textTheme.headline3,
          ),
          automaticallyImplyLeading: false,
          // Uncomment this if you require a close button
          // leeading: const CloseButton()
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile<String?>(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: const VisualDensity(),
                  activeColor: Theme.of(context).iconTheme.color,
                  value:
                      "${widget.sort?.elementAt(index).code}-${ConstantsHelper.directionLowToHigh}",
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                    var arr = value?.split("-");
                    SortingData? sort;
                    widget.sort?.forEach((element) {
                      if (element.code == arr?.elementAt(0)) {
                        element.direction =
                            ConstantsHelper.directionLowToHigh.toString();
                        sort = element;
                      }
                    });
                    widget.onSort(sort);
                  },
                  title: Text(
                    "${widget.sort![index].label} ${getSuffix(widget.sort!.elementAt(index).code.toString(), ConstantsHelper.directionLowToHigh)}",
                  ),
                ),
                RadioListTile<String?>(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: const VisualDensity(),
                  value:
                      "${widget.sort?.elementAt(index).code}-${ConstantsHelper.directionHighToLow}",
                  groupValue: groupValue,
                  activeColor: Theme.of(context).iconTheme.color,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                    var arr = value?.split("-");
                    SortingData? sort;
                    widget.sort?.forEach((element) {
                      if (element.code == arr?.elementAt(0)) {
                        element.direction =
                            ConstantsHelper.directionHighToLow.toString();
                        sort = element;
                      }
                    });
                    widget.onSort(sort);
                  },
                  title: Text(
                    "${widget.sort![index].label} ${getSuffix(widget.sort!.elementAt(index).code.toString(), ConstantsHelper.directionHighToLow)}",
                  ),
                )
              ],
            ),
            itemCount: widget.sort?.length ?? 0,
          ),
        ),
      ],
    );
  }

  String getSuffix(String code, int direction) {
    switch (code) {
      case ConstantsHelper.dataCodeName:
        if (direction == ConstantsHelper.directionLowToHigh) {
          return Utils.getStringValue(
              context, AppStringConstant.sortBySuffixA2Z);
        } else {
          return Utils.getStringValue(
              context, AppStringConstant.sortBySuffixZ2A);
        }
      default:
        if (direction == ConstantsHelper.directionLowToHigh) {
          return Utils.getStringValue(
              context, AppStringConstant.sortBySuffixL2H);
        } else {
          return Utils.getStringValue(
              context, AppStringConstant.sortBySuffixH2L);
        }
    }
  }
}
