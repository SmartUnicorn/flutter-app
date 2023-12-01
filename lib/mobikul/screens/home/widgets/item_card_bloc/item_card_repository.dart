

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

import '../../../../models/homePage/add_to_wishlist_response.dart';
import '../../../../network_manager/api_client.dart';


abstract class ItemCardRepository {

  Future<AddToWishlistResponse?> addToWishList(String productId);
  Future<BaseModel?> removeFromWishList(String productId);
}

class ItemCardRepositoryImp extends ItemCardRepository {


  /// ****AddToWishList**/
  @override
  Future<AddToWishlistResponse?> addToWishList(String productId) async {

    var wishlistAllAllCartData = await ApiClient().addToWishlist(productId);
    return wishlistAllAllCartData!;
  }

  /// ****RemoveFromWishList**/
  @override
  Future<BaseModel?> removeFromWishList(String productId) async {

    var responseData = await ApiClient().removeFromWishlist(productId);
    return responseData!;
  }


}
