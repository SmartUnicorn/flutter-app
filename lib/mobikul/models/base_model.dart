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
part 'base_model.g.dart';


@JsonSerializable()
class BaseModel {
  bool? success;
  String? message;
  String? otherError;
  String? redirect;
  String? eTag;
  int? cartCount;

  BaseModel({
    this.success,
    this.message,
    this.otherError,
    this.redirect,
    this.cartCount
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
