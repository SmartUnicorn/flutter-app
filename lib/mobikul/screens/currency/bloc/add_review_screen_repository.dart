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

import '../../../models/base_model.dart';

abstract class AddReviewRepository {
  Future<BaseModel> addReview(
      int rating, String title, String review, String productId);
}

class AddReviewRepositoryImp implements AddReviewRepository {
  @override
  Future<BaseModel> addReview(
      int rating, String title, String review, String productId) async {
    try {
      final String response = await rootBundle.loadString('assets/responses/base_model_response.json');
      Map<String, dynamic> userMap = jsonDecode(response);
      var responseData = BaseModel.fromJson(userMap);
      return responseData;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }
}
