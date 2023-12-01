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

import '../base_model.dart';

part 'download_product.g.dart';

@JsonSerializable()
class DownloadProduct extends BaseModel{
  String? mimeType;
  String? url;
  String? fileName;
  DownloadProduct({this.mimeType, this.url,this.fileName});

  factory DownloadProduct.fromJson(Map<String, dynamic> json) =>
      _$DownloadProductFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadProductToJson(this);
}