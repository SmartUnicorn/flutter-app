
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

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_events.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_repository.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_states.dart';

class CategoryScreenBloc extends Bloc<CategoryScreenEvent, CategoryScreenState> {
  CategoryScreenRepository? repository;

  CategoryScreenBloc({this.repository}) : super(CategoryScreenInitial()) {
    on<CategoryScreenEvent>(mapEventToState);
  }

  void mapEventToState(CategoryScreenEvent event, Emitter<CategoryScreenState> emit) async {
    if (event is CategoryScreenDataFetchEvent) {
      // emit(CategoryScreenInitial());
      try {
        var model = await repository?.getCategoryData(event.categoryId);
        if (model != null) {
          emit( CategoryScreenSuccess(model));
        } else {
          emit(CategoryScreenError(''));
        }
      } catch (error, stack) {
        print(stack.toString());
        emit(CategoryScreenError(error.toString()));
      }
    }
  }
}