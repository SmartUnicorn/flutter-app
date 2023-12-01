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

import '../../../models/homePage/home_screen_model.dart';
import '../../../models/walk_through/walk_through_model.dart';
import '../../../network_manager/api_client.dart';

abstract class SplashScreenRepository{
  Future<HomePageData> getSplashData();
  Future<WalkThroughModel> getWalkThroughData();
}

class SplashscreenRepositoryImp implements SplashScreenRepository{
  @override
  Future<HomePageData> getSplashData() async{
    HomePageData? responseData;
    try{
      responseData = await ApiClient().getHomePageData(false);
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseData!;

  }

  @override
  Future<WalkThroughModel> getWalkThroughData() async {
    WalkThroughModel? data;
    try {
      data = await ApiClient().getWalkThrough();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return data!;

  }

}