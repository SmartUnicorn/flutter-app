
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

abstract class ProductDetailScreenEvent extends Equatable {
  const ProductDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailScreenDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;
  const ProductDetailScreenDataFetchEvent(this.productId);


  @override
  List<Object> get props => [];
}

//add to wishlist
class AddToWishlistEvent extends ProductDetailScreenEvent{
  String? productId;
  AddToWishlistEvent(this.productId);

}

//remove from wishlist
class RemoveFromWishlistEvent extends ProductDetailScreenEvent{
  String? productId;
  RemoveFromWishlistEvent(this.productId);

}

//add to compare
class AddToCompareEvent extends ProductDetailScreenEvent{
  String? productId;
  AddToCompareEvent(this.productId);

}

//Qty update
class QuantityUpdateEvent extends ProductDetailScreenEvent {
  int? qty;
  QuantityUpdateEvent(this.qty);
}

class AddtoCartEvent extends ProductDetailScreenEvent{
  bool goToCheckout;
  String productId;
  int addQty;
  Map<String, dynamic> productParamsJSON;
  List<dynamic>? relatedProducts;

  AddtoCartEvent(this.goToCheckout, this.productId,this.addQty, this.productParamsJSON, this.relatedProducts);
}
//Update price
class UpdatePriceEvent extends ProductDetailScreenEvent{

  UpdatePriceEvent();
}
//Update price
class UpdateDownloadablePriceEvent extends ProductDetailScreenEvent{

  UpdateDownloadablePriceEvent();
}

class ProductConfigurableDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;
  const ProductConfigurableDataFetchEvent(this.productId);


  @override
  List<Object> get props => [];
}

class ProductUpdatedDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;
  const ProductUpdatedDataFetchEvent(this.productId);

  @override
  List<Object> get props => [];
}