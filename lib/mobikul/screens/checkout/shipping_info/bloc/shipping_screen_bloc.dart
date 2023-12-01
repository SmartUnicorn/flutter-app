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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/bloc/shipping_screen_event.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/bloc/shipping_screen_repository.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/bloc/shipping_screen_state.dart';




class ShippingScreenBloc
    extends Bloc<ShippingScreenEvent, ShippingScreenState> {
  ShippingScreenRepositoryImp? repository;

  ShippingScreenBloc({this.repository}) : super(ShippingScreenInitial()) {
    on<ShippingScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ShippingScreenEvent event, Emitter<ShippingScreenState> emit) async {
    switch (event.runtimeType) {
      case ShippingAddressFetchEvent:
        try {
          var model = await repository?.getShippingAddress();
          if (model != null) {
            emit(ShippingAddressSuccess(model));
          } else {
            emit(ShippingError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(ShippingError(error.toString()));
        }
        break;
      case ShippingMethodsFetchEvent:
        try {
          var model = await repository?.getShippingMethods((event as ShippingMethodsFetchEvent).addressId, event.addressDataModel);

          if (model != null) {
            emit(ShippingMethodSuccess(model));
          } else {
            emit(ShippingError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(ShippingError(error.toString()));
        }
        break;
      case ChangeAddressEvent:
        emit(const ChangeShippingAddressState());
        break;
    }
  }
}
