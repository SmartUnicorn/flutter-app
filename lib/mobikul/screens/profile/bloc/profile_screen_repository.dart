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

import '../../../models/account_info/account_info_model.dart';
import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';
abstract class ProfileScreenRepository{
  Future<BaseModel> logOut();
  Future<AccountInfoModel> setImage(String image,String type);
}

class ProfileScreenRepositoryImp implements ProfileScreenRepository{
  @override
  Future<BaseModel> logOut() async{
    BaseModel? model;
    model = await ApiClient().logout();
    return model!;
  }

  @override
  Future<AccountInfoModel> setImage(String image,String type) async{
    AccountInfoModel? model;
    // Map<String,dynamic> data = {};
    // data[type] = image;
    // String body = json.encode(data);
    // model = await ApiClient().saveAccountInfo(body);
    return model!;
  }
}
