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

part 'place_order_model.g.dart';

@JsonSerializable()
class PlaceOrderModel extends BaseModel{
@JsonKey(name:"email")
  String? email;

@JsonKey(name:"canReorder")
  bool? canReorder;

@JsonKey(name:"orderId")
  String? orderId;

@JsonKey(name:"incrementId")
  String? incrementId;

PlaceOrderModel({this.email, this.orderId, this.incrementId, this.canReorder});

factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => _$PlaceOrderModelFromJson(json);

Map<String,dynamic> toJson() => _$PlaceOrderModelToJson(this);
}

@JsonSerializable()
class CustomerDetails{
  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "firstname")
  String? firstName;

  @JsonKey(name:"groupId")
  int? groupId;

  @JsonKey(name:"guestCustomer")
  int? guestCustomer;

  @JsonKey(name:"lastname")
  String? lastName;

  CustomerDetails({this.email, this.lastName, this.firstName, this.groupId, this.guestCustomer});

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);

}