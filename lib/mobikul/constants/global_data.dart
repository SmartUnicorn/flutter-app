

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

import '../models/address/address_form_data.dart';
import '../models/address/get_address.dart';
import '../models/homePage/cms_data.dart';
import '../models/homePage/home_screen_model.dart';

class GlobalData {
  static String custom_collection = "Custom";
  static String? selectedLanguage="en";
  static HomePageData? homePageData;
  static GetAddress? getAddressData;
  static CheckoutAddressFormDataModel? getCheckoutAddressFormDataModel;
  static List<CmsData> cmsPageData = [];
}
