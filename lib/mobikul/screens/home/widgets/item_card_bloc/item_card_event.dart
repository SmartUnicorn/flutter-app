

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

abstract class ItemCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}


//add to wishlist
class AddToWishlistEvent extends ItemCardEvent{
  String? productId;
  AddToWishlistEvent(this.productId);

}

//remove from wishlist
class RemoveFromWishlistEvent extends ItemCardEvent{
  String? productId;
  RemoveFromWishlistEvent(this.productId);

}