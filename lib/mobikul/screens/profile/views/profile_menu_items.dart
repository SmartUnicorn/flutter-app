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

import '../../../constants/app_constants.dart';
import '../../../models/homePage/footer_menu.dart';
import '../../../models/homePage/home_screen_model.dart';


class ProfileMenuItems {
  int id = 0;
  String title = '';
  String icon = AppImages.placeholder;
  bool? isCMS = false;
  IconData? iconData;
  FooterMenu? cmsData;

  ProfileMenuItems({required this.id, required this.title, this.isCMS, required this.icon, this.cmsData,this.iconData,});

  ProfileMenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}