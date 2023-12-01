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

part 'address_datum.g.dart';

@JsonSerializable()
class AddressDatum {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "addressTitle")
  String? addressTitle;

  @JsonKey(name: "value")
  String? value;

  AddressDatum({this.id, this.addressTitle, this.value});

  factory AddressDatum.fromJson(Map<String, dynamic> json) =>
      _$AddressDatumFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDatumToJson(this);
}
