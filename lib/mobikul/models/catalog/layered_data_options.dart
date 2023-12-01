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

part 'layered_data_options.g.dart';

@JsonSerializable()
class LayeredDataOptions {
  @JsonKey(name: "label")
  String? label;

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "count")
  int? count;

  @JsonKey(ignore: true)
  bool? selected = false;

  LayeredDataOptions({this.label, this.id, this.count, this.selected});

  factory LayeredDataOptions.fromJson(Map<String, dynamic> json) => _$LayeredDataOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$LayeredDataOptionsToJson(this);
}
