
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

import 'package:test_new/mobikul/models/reviews/review_details_model.dart';

import '../../../network_manager/api_client.dart';

abstract class ReviewDetailsScreenRepository {
  Future<ReviewDetailsModel> getReviewDetails(String id);
}

class ReviewDetailsScreenRepositoryImp implements ReviewDetailsScreenRepository {
  @override
  Future<ReviewDetailsModel> getReviewDetails(String id) async {

    ReviewDetailsModel? responseData;
    try{
      responseData = await ApiClient().getReviewDetails(id);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
