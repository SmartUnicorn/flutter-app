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
import '../../../models/reviews/rating_form_data_model.dart';
import '../../../network_manager/api_client.dart';

abstract class AddReviewRepository {
  Future<BaseModel> addReview(int rating, String nickName, String summary, String review, String productId, List<Map<String, String>> ratingData);
  Future<RatingFormDataModel> getRatingFormData();
}

class AddReviewRepositoryImp implements AddReviewRepository {
  @override
  Future<BaseModel> addReview(
      int rating, String nickName, String summary, String review, String productId, List<Map<String, String>> ratingData) async {
    try {
      var model = await ApiClient().saveReview(productId, nickName, review, summary, ratingData);
      return model!;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }

  @override
  Future<RatingFormDataModel> getRatingFormData() async {
    try {
      var model = await ApiClient().getRatingFormData();
      return model!;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }
}
