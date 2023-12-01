
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

import 'package:equatable/equatable.dart';

import '../../../models/notifications/notification_screen_model.dart';

abstract class NotificationScreenState extends Equatable {
  const NotificationScreenState();

  @override
  List<Object> get props => [];
}

class NotificationScreenInitial extends NotificationScreenState {}

class NotificationScreenSuccess extends NotificationScreenState {
  NotificationScreenSuccess(this.notificationScreenModel);

  NotificationScreenModel notificationScreenModel;

  @override
  List<Object> get props => [];
}

class NotificationScreenError extends NotificationScreenState {
  NotificationScreenError(this._message);

  String? _message;
  String? get message => _message;

  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}
