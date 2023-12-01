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
abstract class AddReviewEvent extends Equatable{
  const AddReviewEvent();
  @override
  List<Object> get props => [];
}


class AddReviewSaveEvent extends AddReviewEvent{
  final int rating;
  final String title;
  final String detail;
  final String productId;

  const AddReviewSaveEvent(this.rating,this.title,this.detail,this.productId);
}