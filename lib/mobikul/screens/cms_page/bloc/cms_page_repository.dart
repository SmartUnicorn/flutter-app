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

import 'package:test_new/mobikul/network_manager/api_client.dart';

import '../../../models/cms_page/cms_page_model.dart';

abstract class CmsPageRepository {
  Future<CmsPageModel> getCmsData(String id);
}

class CmsPageRepositoryImp implements CmsPageRepository {
  @override
  Future<CmsPageModel> getCmsData(String id) async{
    var model = await ApiClient().cmsPage(id);
    return model!;
  }
}