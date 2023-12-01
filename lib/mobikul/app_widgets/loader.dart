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
import 'package:test_new/mobikul/constants/app_constants.dart';

import '../configuration/mobikul_theme.dart';

class Loader extends StatelessWidget {
  final String? loadingMessage;

  const Loader({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppSizes.size24,
              color: MobikulTheme.accentColor,
            ),
          ),
          const SizedBox(height: AppSizes.size24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color?>(
              Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
