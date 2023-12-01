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
import 'package:test_new/mobikul/network_manager/api_client.dart';
import '../../../models/base_model.dart';
import '../../../models/order_details/order_detail_model.dart';

abstract class OrderDetailRepository {
  Future<OrderDetailModel> getOrderDetails(String orderEndpoint);
  Future<BaseModel> reorder(String incrementId);
}
class OrderDetailRepositoryImp implements OrderDetailRepository {
  @override
  Future<OrderDetailModel> getOrderDetails(String orderId) async {
    OrderDetailModel? orderDetailModel;
    try{
      orderDetailModel = await ApiClient().getOrderDetails(orderId);
    } catch (error,stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return orderDetailModel!;
   /* try {
      final String response = await rootBundle.loadString('assets/responses/order_details.json');
      Map<String, dynamic> userMap = jsonDecode(response);
      var responseData = OrderDetailModel.fromJson(userMap);
      return responseData;
    } catch (e, err) {
      print(e);
      print(err);
      throw Exception(e);
    }*/
  }
  @override
  Future<BaseModel> reorder(String incrementId) async {

    var responseData = await ApiClient().reorder(incrementId);
    return responseData!;
  }
}
