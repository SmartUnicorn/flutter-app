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

// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'signup_response_model.g.dart';


@JsonSerializable()
class SignupResponseModel extends BaseModel{
  String? customerEmail;
  String? customerName;
  String? customerId;
  String? customerToken;
  int? cartCount;
  String? profileImage;
  String? bannerImage;


  SignupResponseModel(
      {this.customerEmail,
      this.customerName,
      this.customerId,
      this.customerToken,
      this.cartCount,
      this.profileImage,
      this.bannerImage});


  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => _$SignupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseModelToJson(this);



}