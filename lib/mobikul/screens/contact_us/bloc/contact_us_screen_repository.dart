
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

import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';

abstract class ContactUsRepository {
  Future<BaseModel> addComment(String name, String email, String telephone, String comment);
}

class ContactUsRepositoryImp implements ContactUsRepository {
  @override
  Future<BaseModel> addComment(String name, String email, String telephone, String comment) async {
    try {
      var model = await ApiClient().contact(name, email, telephone, comment);
      return model!;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }
}
