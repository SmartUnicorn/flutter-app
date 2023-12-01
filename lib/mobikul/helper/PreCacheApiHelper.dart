


//mobikul  pre-cache
import 'package:hive/hive.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';

import '../models/catalog/request/catalog_product_request.dart';
import '../network_manager/api_client.dart';

//mobikul  pre-cache for category and subcategory
late final Box<Map<dynamic, dynamic>?> mainBox;
 precCacheCategoryPage(int categoryId)  {

  if (AppConstant.enablePrecache) {
    try{
        if (mainBox.containsKey("CategoryPageData:" + categoryId.toString())) {

        } else if (mainBox.containsKey("Categories:" + categoryId.toString())) {

        } else if (mainBox.containsKey("ChildCategories:" + categoryId.toString())) {

        } else {

          ApiClient().getCategoryPageData(categoryId);
        }

    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

//mobikul  pre-cache for catalog products

 preCacheGetCatalogProducts(CatalogProductRequest request)  {

  if (AppConstant.enablePrecache) {
    try{

        if (mainBox.containsKey("CategoryPageData:" + request.id.toString())) {

        } else if (mainBox.containsKey("Categories:" + request.id.toString())) {

        } else if (mainBox.containsKey("ChildCategories:" + request.id.toString())) {

        } else {

          ApiClient().getProductCollectionData(request.type??"", request.id??"", request.page??1, request.filterData??[], request.sortData);
        }


    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }

}

//mobikul  pre-cache for product page data
 precCacheProductPage(String id)  {
  if (AppConstant.enablePrecache) {
    try{
        if (mainBox.containsKey("ProductPageData:" + id.toString())) {
           print("haa data hai");
        } else {
         print("nhi hai");
          ApiClient().productPageDataPrecache(id);
        }
      //});


    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
  }
}

//mobikul  pre-cache homepage data
 precCacheHomePage(bool isRefresh)  {

  if (AppConstant.enablePrecache) {
    try{
      ApiClient().getHomePageData(isRefresh);
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
  }

}

//mobikul  pre-cache banner data
 preCacheBannerData(String type, String id)  {

  if (AppConstant.enablePrecache) {
    if ((type) == "category") {
      Map<String,String>? sort =  Map<String,String>();
      var req = CatalogProductRequest(page: 1, id: id, type: "category",sortData: sort,filterData: []);
      preCacheGetCatalogProducts(req);
    } else if ((type) == "product") {
      precCacheProductPage(id);
    }
  }
}
