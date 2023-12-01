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

import 'home_screen_events.dart';
import 'home_screen_repository.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenRepository? repository;

  HomeScreenBloc({this.repository}) : super(HomeScreenInitial()) {
    on<HomeScreenEvent>(mapEventToState);
  }

  void mapEventToState(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (event is HomeScreenDataFetchEvent) {
      emit(HomeScreenInitial());
      try {
        var model = await repository?.getHomePageData(event.isRefresh);
        if (model != null) {
          if (model.success == true) {
            emit(HomeScreenSuccess(model, event.isRefresh));
          } else if (model.otherError.toString() == "customerNotExist") {
            emit(OtherError(model.message??""));
          }else {
            emit(HomeScreenError(''));
          }
        } else {
          emit(HomeScreenError(''));
        }
      } catch (error, stack) {
        print(stack.toString());
        emit(HomeScreenError(error.toString()));
      }
    } else if (event is CartCountFetchEvent) {
      try {
        var model = await repository?.getCartCount();
        if (model != null) {
          if (model.success == true) {
            emit(CartCountSuccess(model));
          } else if (model.otherError.toString() == "customerNotExist") {
            emit(OtherError(model.message??""));
          }else {
            emit(HomeScreenError(''));
          }
        } else {
          emit(HomeScreenError(''));
        }
      } catch (error, stack) {
        print(stack.toString());
        emit(HomeScreenError(error.toString()));
      }
    }
  }
}
