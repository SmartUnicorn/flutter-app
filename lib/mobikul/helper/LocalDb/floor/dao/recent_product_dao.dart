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

import 'package:floor/floor.dart';
import '../entities/recent_product.dart';

@dao
abstract class RecentProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecentProduct(RecentProduct product);

  // @Query("SELECT * FROM RecentProduct LIMIT 5 ")
  @Query("SELECT * FROM RecentProduct")
  Future<List<RecentProduct>> getProducts();

  @Query("DELETE FROM RecentProduct")
  Future<void> deleteRecentProducts();
}
