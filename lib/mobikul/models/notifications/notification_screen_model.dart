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

part 'notification_screen_model.g.dart';

@JsonSerializable()
class NotificationScreenModel extends BaseModel{

  @JsonKey(name: "notificationList")
  List<Notifications>? notificationList;

  int? error;

  NotificationScreenModel({this.notificationList, this.error});
  factory NotificationScreenModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationScreenModelFromJson(json);


}

@JsonSerializable()
class Notifications {
  @JsonKey(name:"id")
  String? id;
  @JsonKey(name:"productId")
  String? productId;
  String? title;
  @JsonKey(name:"banner")
  String? banner;
  @JsonKey(name:"dominantColor")
  String? dominantColor;
  String? notificationType;
  String? content;
  String? subTitle;

  Notifications(
      {this.id,
        this.productId,
        this.title,
        this.banner,
        this.dominantColor,
        this.notificationType,
        this.content,
        this.subTitle});
  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

}

