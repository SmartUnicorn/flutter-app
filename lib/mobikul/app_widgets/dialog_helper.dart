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
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/mobikul/app_widgets/app_alert_message.dart';
import 'package:test_new/mobikul/app_widgets/app_text_field.dart';
import 'package:test_new/mobikul/app_widgets/widget_space.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';

import '../helper/generic_methods.dart';
import '../helper/utils.dart';

class DialogHelper {

  static confirmationDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm,
      VoidCallback? onCancel,
      String? title,
      String? okButton,
      bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        title: (title != null)
            ? Text(localizations?.translate(title) ?? '',
          style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: AppSizes.textSizeMedium),
        )
            : null,
        content: Text(
          localizations?.translate(text) ?? "",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(
                (localizations?.translate(AppStringConstant.cancel) ?? "")
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button,
              )),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              okButton != null
                  ? okButton.toString().toUpperCase()
                  : (localizations?.translate(AppStringConstant.ok) ?? "")
                      .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //==============Forgot Password Dialog===========//
  static forgotPasswordDialog(
      BuildContext context,
      AppLocalizations? localizations,
      String title,
      String message,
      String email,
      {ValueChanged<String>? onConfirm,
      ValueChanged<bool>? onCancel,
      bool isForgotPassword = true}) {
    var textEditingController = TextEditingController(text: email);
    showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title,
          style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: AppSizes.textSizeMedium),
            ),
            const SizedBox(
              height: AppSizes.spacingLarge,
            ),
            if (isForgotPassword)
              AppTextField(
                  controller: textEditingController,
                  isRequired: true,
                  isPassword: false,
                  validationType: AppStringConstant.email,
                  inputType: TextInputType.emailAddress,
                  hintText: Utils.getStringValue(
                      context, AppStringConstant.emailAddress)),
            // TextField(
            //   cursorColor: Theme.of(context).colorScheme.onPrimary,
            //   controller: textEditingController,
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.zero,
            //     hintText:
            //     localizations?.translate(AppStringConstant.emailAddress),
            //     hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
            //       fontWeight: FontWeight.normal,
            //     ),
            //     border: const UnderlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.zero),
            //         borderSide: BorderSide(
            //           color: AppColors.black,
            //         )),
            //     focusedBorder: const UnderlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.zero),
            //         borderSide: BorderSide(
            //           color: AppColors.black,
            //         )),
            //     enabledBorder: const UnderlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.zero),
            //         borderSide: BorderSide(
            //           color: AppColors.black,
            //         )),
            //   ),
            // )
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(AppSizes.paddingNormal,
            AppSizes.paddingNormal, AppSizes.paddingNormal, 0),
        actionsPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(AppSizes.paddingNormal),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (isForgotPassword) {
                if (textEditingController.text.isEmpty) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showWarning(
                        localizations
                                ?.translate(AppStringConstant.invalidEmail) ??
                            '',
                        context);
                  });
                  return;
                }
                Utils.hideSoftKeyBoard();
                if (onConfirm != null) {
                  onConfirm(textEditingController.text.trim());
                }
              } else {
                if (onConfirm != null) {
                  onConfirm("");
                } //----Just to receive empty callback
              }
              Navigator.of(context).pop();
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white)),
          ),

          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) {
                  onCancel(true);
                }
              },
              child: Text(
                (localizations?.translate(AppStringConstant.cancel) ?? "")
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button,
              )),
          const SizedBox(
            width: 3.0,
          ),
        ],
      ),
    );
  }

  //===============Search Screen Text/Image selection=========//
  static searchDialog(BuildContext context, GestureTapCallback onImageTap,
      GestureTapCallback onTextTap) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      useRootNavigator: false,
      context: context,
      builder: (ctx) => AlertDialog(
        // titlePadding: const EdgeInsets.all(AppSizes.genericPadding),
        title: Text(
            GenericMethods.getStringValue(
                context, AppStringConstant.searchByScanning),
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: AppColors.lightGray)),
        backgroundColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(AppSizes.spacingNormal),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: onTextTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.format_color_text),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.spacingNormal),
                    child: Text(
                        GenericMethods.getStringValue(
                            context, AppStringConstant.textSearch),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onImageTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.image_search),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.spacingNormal),
                    child: Text(
                        GenericMethods.getStringValue(
                            context, AppStringConstant.imageSearch),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=====================SignUp Term And Conditions===================//

  static signUpTerms(
    String data,
    BuildContext context,
  ) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        contentPadding: const EdgeInsets.all(AppSizes.size8),
        content: Html(
          data: data,
          style: {"body": Style(fontSize: FontSize.large)},
        ),
      ),
    );
  }


  static networkErrorDialog(BuildContext context, {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          GenericMethods.getStringValue(
              context, AppStringConstant.networkError),
          style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        content: Text(
          GenericMethods.getStringValue(
              context, AppStringConstant.networkConnectionError),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onConfirm != null) {
                closeDialog(ctx);
                onConfirm();
              }
            },
            child: Text(
                GenericMethods.getStringValue(
                    context, AppStringConstant.tryAgain),
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static deleteAccountConfirmationDialog(BuildContext context, String title,
      String description, Function(String)? onConfirm) {
    TextEditingController _passwordEditingController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: AppSizes.textSizeMedium),),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: AppSizes.textSizeMedium),
              ),
              widgetSpace(),
              AppTextField(
                onSave: (value) {},
                controller: _passwordEditingController,
                isPassword: true,
                validation: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return GenericMethods.getStringValue(
                            context, AppStringConstant.password) +
                        " " +
                        GenericMethods.getStringValue(
                            context, AppStringConstant.required);
                  }
                  if (value.toString().length < 6) {
                    return GenericMethods.getStringValue(
                        context, AppStringConstant.passwordValidationMessage);
                  }
                },
                labelText: GenericMethods.getStringValue(
                    context, AppStringConstant.password),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              closeDialog(ctx);
            },
            child: Text(
              GenericMethods.getStringValue(context, AppStringConstant.cancel)
                  .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              closeDialog(ctx);
              print("validate ${_formKey.currentState?.validate()}");
              if (_formKey.currentState?.validate() == true) {
                Utils.hideSoftKeyBoard();
                if (onConfirm != null) {
                  //closeDialog(ctx);
                  onConfirm(_passwordEditingController.text);
                }
              }
            },
            child: Text(
                GenericMethods.getStringValue(context, AppStringConstant.ok)
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
