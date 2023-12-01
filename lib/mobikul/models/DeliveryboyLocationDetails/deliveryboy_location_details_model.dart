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

import '../base_model.dart';
part 'deliveryboy_location_details_model.g.dart';

@JsonSerializable()
class DeliveryBoyLocationDetailsModel extends BaseModel{
  @JsonKey(name:"latitude")
  String? latitude;

  @JsonKey(name:"longitude")
  String? longitude;

  DeliveryBoyLocationDetailsModel({
    this.latitude,
    this.longitude

  });
  factory DeliveryBoyLocationDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryBoyLocationDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryBoyLocationDetailsModelToJson(this);
}