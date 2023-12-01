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

import '../../../models/base_model.dart';
import '../../../models/reviews/rating_form_data_model.dart';

abstract class DeliveryboyWriteReviewScreenState {
  const DeliveryboyWriteReviewScreenState();

  @override
  List<Object> get props => [];
}


class DeliveryboyWriteLoadingState extends DeliveryboyWriteReviewScreenState{}
class DeliveryboyWriteEmptyState extends DeliveryboyWriteReviewScreenState{}

class GetRatingFormDataSuccessState extends DeliveryboyWriteReviewScreenState{
  final RatingFormDataModel data;
  const GetRatingFormDataSuccessState(this.data);
}
class GetAddReviewSuccessState extends DeliveryboyWriteReviewScreenState{
  final BaseModel data;
  const GetAddReviewSuccessState(this.data);
}

class DeliveryboyWriteErrorState extends DeliveryboyWriteReviewScreenState{
  final String message;
  const DeliveryboyWriteErrorState(this.message);
}


