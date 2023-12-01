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

import 'package:test_new/mobikul/models/search/search_screen_model.dart';

import '../../../../network_manager/api_client.dart';

abstract class SearchRepository{
Future<SearchScreenModel> getSearchSuggestion(String searchQuery);
}

class SearchRepositoryImp implements SearchRepository{
  @override
  Future<SearchScreenModel> getSearchSuggestion(String searchQuery) async{

    SearchScreenModel? responseData;
    try{
      responseData = await ApiClient().getSearchSuggestionData(searchQuery);
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseData!;
  }

}