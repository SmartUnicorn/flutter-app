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

import '../badge_icon.dart';
import 'bottom_tabbar.dart';

class BadgeIconUpdate extends StatefulWidget {
  const BadgeIconUpdate({Key? key}) : super(key: key);

  @override
  State<BadgeIconUpdate> createState() => _BadgeIconUpdateState();
}

class _BadgeIconUpdateState extends State<BadgeIconUpdate> {
  late int _badgeCount;

  @override
  void initState() {
    _badgeCount = 0;
    _registerStreamListener();
    super.initState();
  }

  void _registerStreamListener() {
    if(mounted){
    TabBarController.countController.stream.listen((event) {
      if(mounted){
      setState(() {});}
      _badgeCount = event;
      print("badge count $event");
    });}
  }

  @override
  Widget build(BuildContext context) {
    return BadgeIcon(
      icon: const Icon(Icons.shopping_cart_outlined),
      badgeColor: Colors.red,
    );
  }
}
