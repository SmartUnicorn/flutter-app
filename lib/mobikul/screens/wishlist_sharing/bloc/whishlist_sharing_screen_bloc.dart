

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

import 'wishlist_sharing_screen_event.dart';
import 'wishlist_sharing_screen_repository.dart';
import 'wishlist_sharing_screen_state.dart';


class WishlistSharingBloc extends Bloc<WishlistSharingEvent, WishlistSharingState> {
  WishlistSharingRepository? repository;

  WishlistSharingBloc({this.repository}) : super(WishlistSharingInitialState()) {
    on<WishlistSharingEvent>(mapEventToState);
  }

  void mapEventToState(WishlistSharingEvent event, Emitter<WishlistSharingState> emit,) async {
    if (event is WishListSharingSubmitEvent) {
      emit(WishlistSharingInitialState());
      try {
        var model = await repository?.shareWishList(event.email, event.message);
        if (model != null) {
          if (model.success ?? false) {
            emit(WishlistSharingSuccessState(model));
          } else {
            emit(WishlistSharingErrorState(model?.message));
          }
        } else {
          emit(WishlistSharingErrorState(""));
        }
      } catch (error, _) {
        emit(WishlistSharingErrorState(error.toString()));
      }
    }
  }
}