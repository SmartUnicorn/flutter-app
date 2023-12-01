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
import 'package:test_new/mobikul/models/base_model.dart';

part 'print_invoice_model.g.dart';

@JsonSerializable()
class PrintInvoiceModel extends BaseModel {

  @JsonKey(name: "url")
  String? url;

  PrintInvoiceModel(
      {
        this.url,
      });

  factory PrintInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$PrintInvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrintInvoiceModelToJson(this);

}