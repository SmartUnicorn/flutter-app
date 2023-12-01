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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/mobikul/models/order_details/order_detail_model.dart';

abstract class RefundScreenRepository {
  Future<Creditmemo> getInvoiceList(String page);
}

class RefundScreenRepositoryImp implements RefundScreenRepository {
  @override
  Future<Creditmemo> getInvoiceList(String page) async {
    return Creditmemo();
  }
}
