
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

import '../../../../models/address/address_form_data.dart';

abstract class ShippingScreenEvent extends Equatable{
  const ShippingScreenEvent();

  @override
  List<Object> get props => [];
}


class ShippingAddressFetchEvent extends ShippingScreenEvent {
  const ShippingAddressFetchEvent();

  @override
  List<Object> get props => [];
}

class ChangeAddressEvent extends ShippingScreenEvent {
  const ChangeAddressEvent();

  @override
  List<Object> get props => [];
}

class ShippingMethodsFetchEvent extends ShippingScreenEvent {
  String addressId;
  AddressDataModel addressDataModel;
  ShippingMethodsFetchEvent(this.addressId, this.addressDataModel);

  @override
  List<Object> get props => [];
}
