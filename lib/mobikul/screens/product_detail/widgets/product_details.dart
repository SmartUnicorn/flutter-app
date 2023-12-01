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

// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_webview.dart';

class ProductDetailsView extends StatefulWidget {
  String? description;

  ProductDetailsView(this.description, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: AppSizes.size8),
      child: ExpansionTile(
        initiallyExpanded: (widget.description ?? '' ) != "" ? true : false,
          title: Text(
              Utils.getStringValue(context, AppStringConstant.details) ?? '',
              style: Theme.of(context).textTheme.subtitle2),
          children: [
            Container(
                padding: const EdgeInsets.all(AppSizes.size8),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Html(data:widget.description ?? ''),
                    // ProductsWebView(widget.description ?? '')
                  ],
                )),
          ]),
    );
  }
}
