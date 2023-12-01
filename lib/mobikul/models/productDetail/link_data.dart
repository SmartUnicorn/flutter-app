
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

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'link_data.g.dart';

@JsonSerializable()
class LinkData{
  String? id;
  String? linkTitle;
  String? price;
  String? formattedPrice;
  String? url;
  String? fileName;
  int? haveLinkSample;
  String? linkSampleTitle;

  LinkData(this.id, this.linkTitle, this.price, this.formattedPrice, this.url,
      this.fileName, this.haveLinkSample, this.linkSampleTitle);

  factory LinkData.fromJson(Map<String, dynamic> json) =>
      _$LinkDataFromJson(json);

  Map<String, dynamic> toJson() => _$LinkDataToJson(this);


}