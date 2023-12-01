
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

import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/network_manager/api_client_retrofit.dart';
import '../../../models/google_place_model.dart';

abstract class LocationRepository{
  Future<GooglePlaceModel> getPlace(String text);
}

class LocationRepositoryImp implements LocationRepository{
  @override
  Future<GooglePlaceModel> getPlace(String text)async{
    GooglePlaceModel? model;
    String endPoint = "$text&key=${AppConstant.googleKey}";
    model = await ApiClientRetrofit(baseUrl: "https://maps.googleapis.com/maps/api/").getGooglePlace(endPoint);
    return model!;
  }
}
