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

import 'package:bloc/bloc.dart';

import 'item_card_event.dart';
import 'item_card_repository.dart';
import 'item_card_state.dart';

class ItemCardBloc extends Bloc<ItemCardEvent, ItemCardState> {
  ItemCardRepository? repository;

  ItemCardBloc({this.repository}) : super(ItemCardInitial()) {
    on<ItemCardEvent>(mapEventToState);
  }

  void mapEventToState(ItemCardEvent event, Emitter<ItemCardState> emit) async {
    emit(ItemCardInitial());
    //AddToWishList
    if (event is AddToWishlistEvent) {
      try {
        var model = await repository?.addToWishList(event.productId ?? "");
        if (model != null) {
          emit(AddProductToWishlistStateSuccess(model, event.productId ?? ''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ItemCardErrorState(error.toString()));
      }
    } else if (event is RemoveFromWishlistEvent) {
      try {
        var model = await repository?.removeFromWishList(event.productId ?? "");
        if (model != null) {
          emit(RemoveFromWishlistStateSuccess(model, event.productId ?? ''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ItemCardErrorState(error.toString()));
      }
    }
  }
}
