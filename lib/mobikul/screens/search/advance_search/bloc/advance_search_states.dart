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
import 'package:test_new/mobikul/models/search/advance_search_model.dart';

abstract class AdvanceSearchState extends Equatable{
  const AdvanceSearchState();

  @override
  List<Object> get props => [];
}

class AdvanceSearchLoadingState extends AdvanceSearchState{}

class AdvanceSearchScreenSuccess extends AdvanceSearchState{
  final AdvanceSearchModel? advanceSearchModel;

  const AdvanceSearchScreenSuccess(this.advanceSearchModel);
}

class AdvanceSearchScreenError extends AdvanceSearchState {
  const AdvanceSearchScreenError(this.message);

  final String message;
}