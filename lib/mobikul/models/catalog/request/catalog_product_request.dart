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
import 'package:test_new/mobikul/models/catalog/sorting_data.dart';

part 'catalog_product_request.g.dart';

@JsonSerializable()
class CatalogProductRequest {
  int? page;
  String? id;
  String? type;
  Map<String, String>? sortData;
  List<Map<String, String>>? filterData;

  CatalogProductRequest({
    this.page,
    this.id,
    this.type,
    this.sortData,
    this.filterData,
  });

  factory CatalogProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CatalogProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogProductRequestToJson(this);
}
