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
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_state.dart';

class WishlistScreenBloc
    extends Bloc<WishlistScreenEvents, WishlistScreenState> {
  WishlistScreenRepository? repository;
  static const String Tag = "WishlistScreenBloc:- ";

  WishlistScreenBloc({this.repository}) : super(WishlistInitialState()) {
    on<WishlistScreenEvents>(mapEventToState);
  }

  @override
  void mapEventToState(
      WishlistScreenEvents event, Emitter<WishlistScreenState> emit) async {
    if (event is WishlistDataFetchEvent) {
      // emit(WishlistInitialState());
      try {
        var model = await repository?.getWishlistData(event.pagenumber);
        if (model != null) {
          print(Tag + " success ");
          emit(WishlistScreenSuccess(model));
        } else {
          print(Tag + " api wishlist api Fail");
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(Tag + " Exception " + error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    } else if (event is MoveToCartEvent) {
      try {
        var model = await repository?.moveCartWishlist(
            event.productId ?? 0, event.quantity ?? 0, event.itemId ?? 0);
        if (model != null) {
          if (model.success ?? false) {
            emit(MoveToCartSuccess(model));
          } else {
            emit(WishlistScreenError(model?.message));
          }
        } else {
          emit(WishlistScreenError(model?.message));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }

    } else if (event is MoveAllToCartEvent) {
      try {
        var model = await repository?.addAllCartWishlist(event.itemData ?? []);
        if (model != null) {
          if (model.success ?? false) {
            emit(MoveAllToCartSuccess(model));
          } else {
            emit(WishlistScreenError(model?.message));
          }
        } else {
          emit(WishlistScreenError(model?.message));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    } else if (event is RemoveItemEvent) {
      try {
        var model = await repository?.removeCartFromWishlist(event.productId);
        if (model != null) {
          emit(RemoveItemSuccess(model));
        } else {
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    }
  }
}
