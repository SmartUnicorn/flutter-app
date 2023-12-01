

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

import '../../../models/catalog/catalog_model.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../network_manager/api_client.dart';

abstract class CatalogRepository {
  Future<CatalogModel> getCatalogProducts(CatalogProductRequest request);
}

class CatalogRepositoryImpl extends CatalogRepository {
  @override
  Future<CatalogModel> getCatalogProducts(CatalogProductRequest request) async {


    CatalogModel? responseData;
    try{
      responseData = await ApiClient().getProductCollectionData(request.type??"", request.id??"", request.page??1, request.filterData??[], request.sortData);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
