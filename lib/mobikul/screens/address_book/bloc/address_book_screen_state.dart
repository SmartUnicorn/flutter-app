
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
import 'package:test_new/mobikul/models/address/get_address.dart';

import '../../../models/base_model.dart';

abstract class AddressBookScreenState {
  const AddressBookScreenState();

  @override
  List<Object> get props => [];
}

class AddressBookScreenInitial extends AddressBookScreenState {
}


class AddressBookScreenSuccess extends AddressBookScreenState {

  GetAddress getAddress;
  AddressBookScreenSuccess(this.getAddress);
  @override
  List<Object> get props => [];
}


class DeleteAddressSuccess extends AddressBookScreenState{
  BaseModel? baseModel;

  DeleteAddressSuccess(this.baseModel);

  @override
  List<Object> get props => [];
}

class AddAddressSuccess extends AddressBookScreenState {
  final BaseModel model;

  const AddAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}


class AddressBookScreenError extends AddressBookScreenState {
  AddressBookScreenError(this._message);
  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }
  @override
  List<Object> get props => [];
}

class CompleteState extends AddressBookScreenState{}
