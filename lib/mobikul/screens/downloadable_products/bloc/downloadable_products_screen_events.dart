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

abstract class DownloadableProductsScreenEvent extends Equatable{
  const DownloadableProductsScreenEvent();

  @override
  List<Object> get props => [];
}

class DownloadableProductsScreenDataFetchEvent extends DownloadableProductsScreenEvent{
  final String page;
  const DownloadableProductsScreenDataFetchEvent(this.page);
}

class DownloadableProductsDetailsFetchEvent extends DownloadableProductsScreenEvent{
  final String downloadableProductsId;
  const DownloadableProductsDetailsFetchEvent(this.downloadableProductsId);
}

class DownloadProductEvent extends DownloadableProductsScreenEvent{
  final String itemHash;
  const DownloadProductEvent(this.itemHash);
}
