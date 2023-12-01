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
part 'cms_page_model.g.dart';

@JsonSerializable()
class CmsPageModel{
  String? title;
  String? content;
  CmsPageModel({this.title, this.content});
  factory CmsPageModel.fromJson(Map<String, dynamic> json) =>
      _$CmsPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CmsPageModelToJson(this);
}