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

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/mobikul/models/base_model.dart';

import 'home_page_languages.dart';
part 'cms_data.g.dart';


@JsonSerializable()
class CmsData extends BaseModel {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  CmsData({this.id, this.title});

  factory CmsData.fromJson(Map<String, dynamic> json) =>
      _$CmsDataFromJson(json);


  Map<String, dynamic> toJson() => _$CmsDataToJson(this);
}
