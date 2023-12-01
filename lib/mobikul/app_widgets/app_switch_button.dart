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

import '../configuration/mobikul_theme.dart';
import '../constants/app_constants.dart';

class AppSwitchButton extends StatefulWidget {
  bool isOn;
  final String title;
  final ValueChanged<bool> callback;
  bool isFromPaymentInfo;
  AppSwitchButton(this.title, this.callback, this.isOn,
      {Key? key, this.isFromPaymentInfo = false})
      : super(key: key);

  @override
  State<AppSwitchButton> createState() => _AppSwitchButtonState();
}

class _AppSwitchButtonState extends State<AppSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSizes.size10)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: widget.isFromPaymentInfo,
            child: Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.size8),
                    child: Text(widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.normal)),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          Switch(
            activeColor: Theme.of(context).colorScheme.outline,
            value: widget.isOn,
            onChanged: (value) {
              setState(() {
                widget.isOn = value;
                widget.callback(widget.isOn);
              });
            },
          ),
          Visibility(
            visible: !widget.isFromPaymentInfo,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.size8),
              child: Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.normal)),
            ),
          ),
        ],
      ),
    );
  }
}
