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

import '../../../models/catalog/request/catalog_product_request.dart';

abstract class CatalogScreenEvent extends Equatable {}

class ChangeViewEvent extends CatalogScreenEvent {
  final bool isGrid;

  ChangeViewEvent(this.isGrid);

  @override
  List<Object> get props => [];
}

class LoadingEvent extends CatalogScreenEvent {
  LoadingEvent();

  @override
  List<Object?> get props => [];
}

class FetchCatalogEvent extends CatalogScreenEvent {
  FetchCatalogEvent(this.request);

  final CatalogProductRequest request;

  @override
  List<Object> get props => [request];
}

