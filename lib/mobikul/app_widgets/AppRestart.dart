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

class AppRestart extends StatefulWidget {
  final Widget? child;
  static bool isOpenHomePage = false;
  AppRestart({ this.child});

  @override
  _AppRestartState createState() => _AppRestartState();

  static rebirth(BuildContext context) {
    context.findAncestorStateOfType<_AppRestartState>()!.restartApp();
  }
}

class _AppRestartState extends State<AppRestart> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}