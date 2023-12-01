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
abstract class DeliveryboyWriteReviewEvent extends Equatable{
  const DeliveryboyWriteReviewEvent();
  @override
  List<Object> get props => [];
}


class GetRatingFormDataEvent extends DeliveryboyWriteReviewEvent{
  GetRatingFormDataEvent();
}

class AddReviewSaveEvent extends DeliveryboyWriteReviewEvent{
  final int rating;
  final int customerId;
  final String title;
  final String comment;
  final int deliveryboyId;
  final String orderId;
  final String nickName;

  AddReviewSaveEvent(this.rating,this.customerId,this.title,this.comment,this.deliveryboyId,this.orderId, this.nickName);
}