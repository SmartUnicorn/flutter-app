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
import 'package:test_new/mobikul/app_widgets/app_outlined_button.dart';
import 'package:test_new/mobikul/app_widgets/app_text_field.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/utils.dart';

class DiscountView extends StatefulWidget {
  const DiscountView(
      {required this.discountApplied,
      required this.discountCode,
      required this.onClickApply,
      required this.onClickRemove,
      Key? key})
      : super(key: key);

  final bool discountApplied;
  final String discountCode;
  final Function(String)? onClickApply;
  final Function(String)? onClickRemove;
  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  TextEditingController codeController = TextEditingController();
  late FocusNode codeControllerNode;
  AppLocalizations? _localizations;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations?.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    codeControllerNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.discountApplied) {
      codeController.text = widget.discountCode ?? "";
    } else {
      codeController.text = "";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size1),
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListTileTheme(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppSizes.size8),
          child: ExpansionTile(
            leading: Icon(
              Icons.discount,
              color: Theme.of(context).iconTheme.color,
            ),
            iconColor: Theme.of(context).iconTheme.color,
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: AppSizes.size12),
            initiallyExpanded: true,
            title: Text(
                (_localizations?.translate(
                          AppStringConstant.discountCode,
                        ) ??
                        "")
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(AppSizes.size4,
                      AppSizes.size8, AppSizes.size4, AppSizes.size8),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                            isDense: true,
                            isRequired: false,
                            focusNode: codeControllerNode,
                            controller: codeController,
                            readOnly: widget.discountApplied ? true : false,
                            isPassword: false,
                            validationMessage: "Please enter some text",
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.enterCode),
                            suffix: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (codeController.text.isNotEmpty) {
                                    if (widget.discountApplied) {
                                      widget
                                          .onClickRemove!(codeController.text);
                                    } else {
                                      widget.onClickApply!(codeController.text);
                                    }
                                  } else {
                                    codeControllerNode.requestFocus();
                                  }
                                }
                              },
                              child: Container(
                                width: AppSizes.deviceWidth / 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius:const BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  widget.discountApplied
                                      ? Utils.getStringValue(
                                              context, AppStringConstant.remove)
                                          .toUpperCase()
                                      : Utils.getStringValue(
                                              context, AppStringConstant.apply)
                                          .toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.white,
                                  ),
                                )),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
