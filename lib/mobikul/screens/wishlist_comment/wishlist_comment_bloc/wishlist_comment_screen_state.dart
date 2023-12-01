
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

abstract class WishlistCommentScreenState extends Equatable {
  const WishlistCommentScreenState();

  @override
  List<Object?> get props => [];

}


class WishlistCommentScreenInitialState extends WishlistCommentScreenState{}

class WishlistCommentScreenLoadingState extends WishlistCommentScreenState{}

class WishlistCommentScreenSuccessState extends WishlistCommentScreenState{
}

class WishlistCommentScreenErrorState extends WishlistCommentScreenState{
  final String message;
  const WishlistCommentScreenErrorState(this.message);
}

