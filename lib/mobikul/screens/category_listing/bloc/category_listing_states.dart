
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

import '../../../models/categoryPage/category_page_response.dart';

abstract class CategoryListingState {
  const CategoryListingState();

  @override
  List<Object> get props => [];
}

class CategoryListingInitial extends CategoryListingState {

}

class CategoryListingSuccess extends CategoryListingState {

  CategoryPageResponse categoryPageResponse;
  CategoryListingSuccess(this.categoryPageResponse);
  @override
  List<Object> get props => [];
}

class CategoryListingError extends CategoryListingState {
  CategoryListingError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}