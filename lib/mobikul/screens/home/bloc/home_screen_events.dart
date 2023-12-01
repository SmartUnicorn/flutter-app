
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

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class HomeScreenDataFetchEvent extends HomeScreenEvent {

  final bool isRefresh;
  const HomeScreenDataFetchEvent(this.isRefresh);


  @override
  List<Object> get props => [];
}
class CartCountFetchEvent extends HomeScreenEvent {
  const CartCountFetchEvent();


  @override
  List<Object> get props => [];
}
