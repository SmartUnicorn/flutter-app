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

import 'package:json_annotation/json_annotation.dart';

part 'wishlist_product_request.g.dart';

@JsonSerializable()
class WishlistProductRequest {
  String? eTag;
  String? storeId;
  String? customerToken;
  String? currency;
  String? pageNumber;

  WishlistProductRequest({
    this.eTag,
    this.storeId,
    this.customerToken,
    this.currency,
    this.pageNumber
  });

  factory WishlistProductRequest.fromJson(Map<String, dynamic> json) =>
      _$WishlistProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistProductRequestToJson(this);
}
