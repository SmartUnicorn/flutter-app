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
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants/app_constants.dart';


class AppTable extends StatelessWidget {
  const AppTable(this.data, this.heading, {this.scroll = true, Key? key})
      : super(key: key);

  final List<List<dynamic>> data; //-----------pass list for value
  final List<String> heading; //---------Pass List for heading
  final bool scroll;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: DataTable(
          horizontalMargin: AppSizes.size8,
          columnSpacing: AppSizes.size10,
          columns: heading
              .map((e) => DataColumn(
                      label: Expanded(
                    child: SizedBox(
                      width: (AppSizes.deviceWidth / 3.5),
                      child: Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  )))
              .toList(),
          rows: data
              .map((e) => DataRow(
                    cells: e
                        .map((e) => DataCell(SizedBox(
                            width: AppSizes.deviceWidth / 3.5,
                            child: Center(
                              child: SingleChildScrollView(
                                child:Html(
                                 data: e,
                               shrinkWrap: true,
                               /* overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 3,*/
                              )),
                            ))))
                        .toList(),
                  ))
              .toList(),
        ));
  }
}
