
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

abstract class CategoryScreenEvent extends Equatable {
  const CategoryScreenEvent();

  @override
  List<Object> get props => [];
}

class CategoryScreenDataFetchEvent extends CategoryScreenEvent {
   int categoryId;
   CategoryScreenDataFetchEvent(this.categoryId);
  @override
  List<Object> get props => [];
}