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

import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/models/login_signup/signup_response_model.dart';

import '../../../helper/push_notifications_manager.dart';
import '../../../models/base_model.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../../models/login_signup/sign_up_screen_model.dart';
import '../../../models/login_signup/social_login_model.dart';
import '../../../network_manager/api_client.dart';


abstract class SigninSignupScreenRepository {
  Future<SignUpScreenModel>? signUpFormData();

  Future<SignupResponseModel>? signUp(
      String prefix,
      String firstName,
      String middleName,
      String lastName,
      String suffix,
      String dob,
      String taxvat,
      String gender,
      String email,
      String password,
      String mobile
  );

  Future login(String email, String password);

  Future forgotPassword(String email);

  Future<SignupResponseModel>? socialLogin(SocialLoginModel socialLoginRequest);
}

class SigninSignupScreenRepositoryImp implements SigninSignupScreenRepository {
  @override
  Future<SignUpScreenModel>? signUpFormData() async {
    SignUpScreenModel? responseModel;
    try{
      responseModel = await ApiClient().createAccountFormData();
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }

  @override
  Future<SignupResponseModel>? signUp(
      String prefix,
      String firstName,
      String middleName,
      String lastName,
      String suffix,
      String dob,
      String taxvat,
      String gender,
      String email,
      String password,
      String mobile
      ) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId==>$firebaseToken");
    SignupResponseModel? responseModel;
    try{
      responseModel = await ApiClient().createAccount(
          prefix,
          firstName,
          middleName,
          lastName,
          suffix,
          dob,
          taxvat,
          gender,
          email,
          password,
          mobile,
          firebaseToken??"",
          0
      );
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }

  @override
  Future forgotPassword(String email) async {
    BaseModel? responseModel;
    try{
      responseModel = await ApiClient().forgotPassword(email);
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }

  @override
  Future login(String email, String password) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId==>$firebaseToken");
    LoginResponseModel? responseModel;
    try{
      responseModel = await ApiClient().customerLogin(email, password, firebaseToken??"");
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }

  @override
  Future<SignupResponseModel>? socialLogin(SocialLoginModel socialLoginRequest) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId==>$firebaseToken");
    SignupResponseModel? responseModel;
    try{
      responseModel = await ApiClient().createAccount(
          "",
          socialLoginRequest.firstName??"",
          "middleName",
          socialLoginRequest.lastName??"",
          "",
          "",
          "",
          "",
          socialLoginRequest.email??"",
          socialLoginRequest.id??"",
          "",
          firebaseToken??"",
          1
      );
    }
    catch(e, stacktrace){
      print("Error --> " + e.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseModel!;
  }
}
