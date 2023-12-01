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

import 'package:equatable/equatable.dart';
import 'package:test_new/mobikul/models/order_list/order_list_model.dart';

import '../../../models/account_info/account_info_model.dart';
import '../../../models/address/get_address.dart';
import '../../../models/base_model.dart';
abstract class DashboardState {
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState{}

class DashboardSuccessState extends DashboardState{
  final OrderListModel order;
  final GetAddress address;
  const DashboardSuccessState(this.order, this.address);
}

class DashboardErrorState extends DashboardState{
  final String message;
  const DashboardErrorState(this.message);
}

class DashboardOrderSuccessState extends DashboardState{
  final OrderListModel order;
  const DashboardOrderSuccessState(this.order);
}

class DashboardAddressSuccessState extends DashboardState{
  final GetAddress address;
  const DashboardAddressSuccessState(this.address);
}
 class ChangeShippingAddressState extends DashboardState{}

class SaveShippingAddressState extends DashboardState{
  final BaseModel data;
  const SaveShippingAddressState(this.data);
}

class AddImageState extends DashboardState{
  final AccountInfoModel? model;
  final String? type;
  const AddImageState(this.model, this.type);
}

class DeleteImageState extends DashboardState{
  final BaseModel? model;
  const DeleteImageState(this.model);
}
class DeleteBannerImageState extends DashboardState{
  final BaseModel? model;
  const DeleteBannerImageState(this.model);
}