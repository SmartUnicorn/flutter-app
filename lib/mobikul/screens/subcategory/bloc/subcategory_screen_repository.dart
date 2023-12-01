
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

import '../../../models/categoryPage/category_page_response.dart';
import '../../../network_manager/api_client.dart';

abstract class SubCategoryScreenRepository{
  Future<CategoryPageResponse> getCategoryData(int categoryId);
}

class SubCategoryScreenRepositoryImp extends SubCategoryScreenRepository{
  @override
  Future<CategoryPageResponse> getCategoryData(int categoryId) async {
    CategoryPageResponse? responseData;
    try {
      responseData = await ApiClient().getCategoryPageData(categoryId);
    }
    catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}