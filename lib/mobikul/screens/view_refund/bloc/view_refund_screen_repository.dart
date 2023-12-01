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

import 'package:test_new/mobikul/network_manager/api_client.dart';

import '../../../models/refund_view/refund_view_model.dart';


abstract class ViewRefundScreenRepository {
  Future<RefundViewModel> getInvoiceView(String creditMemoId);
}
class ViewRefundScreenRepositoryImp implements ViewRefundScreenRepository {
  @override
  Future<RefundViewModel> getInvoiceView(String creditMemoId) async {
    RefundViewModel? responseData;
    try {
      responseData = await ApiClient().getCreditView(creditMemoId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return responseData!;
  }


}
