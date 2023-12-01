
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
import 'package:test_new/mobikul/models/address/get_address.dart';
import 'package:test_new/mobikul/network_manager/api_client.dart';

import '../../../models/address/add_address_request.dart';
import '../../../models/base_model.dart';

abstract class AddressBookRepositoryScreen{
  Future<GetAddress> getAddressData(int forDashboard);
  Future<BaseModel> deleteAddress(String addressId);
  // Future<BaseModel> saveAddress(String addressId, AddAddressRequest request);

}

class AddressBookRepositoryScreenImp extends AddressBookRepositoryScreen{
  @override
  Future<GetAddress> getAddressData(int forDashboard) async {
    GetAddress? addressdata;
    try{
      addressdata = await ApiClient().getAddressData(forDashboard);
    } catch(error, stacktrace) {
      print("Error --> " + error.toString());
      print("Stacktrace --> " + stacktrace.toString());
    }
    return addressdata!;
  }

  @override
  Future<BaseModel> deleteAddress(String addressId) async {
    var deleteAddress = await ApiClient().deleteAddress(addressId);
    return deleteAddress!;
  }

  /*@override
  Future<BaseModel> saveAddress(String addressId, AddAddressRequest addAddressRequest) async {
    var saveAddress = await ApiClient().saveAddress(addressId, addAddressRequest);
    return saveAddress!;
  }*/
}
