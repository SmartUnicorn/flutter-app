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

import 'package:test_new/mobikul/models/base_model.dart';

import '../../../network_manager/api_client.dart';

abstract class WishlistSharingRepository {
  Future shareWishList(String email, String message);

}

class WishlistSharingRepositoryImp implements WishlistSharingRepository {


  @override
  Future shareWishList(String email, String message) async {
    // var firebaseToken = await PushNotificationsManager().createFcmToken();
    // print("deviceId==>$firebaseToken");
    BaseModel? responseModel;
    try{
      responseModel = await ApiClient().shareWishList(email, message);
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }
}
