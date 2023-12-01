
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

abstract class CategoryListingEvent extends Equatable {
  const CategoryListingEvent();

  @override
  List<Object> get props => [];
}

class CategoryListingDataFetchEvent extends CategoryListingEvent {
   int categoryId;
   CategoryListingDataFetchEvent(this.categoryId);
  @override
  List<Object> get props => [];
}