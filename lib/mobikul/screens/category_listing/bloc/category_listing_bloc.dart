
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

import 'category_listing_events.dart';
import 'category_listing_repository.dart';
import 'category_listing_states.dart';


class CategoryListingBloc extends Bloc<CategoryListingEvent, CategoryListingState> {
  CategoryListingRepository? repository;

  CategoryListingBloc({this.repository}) : super(CategoryListingInitial()) {
    on<CategoryListingEvent>(mapEventToState);
  }

  void mapEventToState(CategoryListingEvent event, Emitter<CategoryListingState> emit) async {
    if (event is CategoryListingDataFetchEvent) {
      // emit(CategoryScreenInitial());
      try {
        var model = await repository?.getCategoryData(event.categoryId);
        if (model != null) {
          emit( CategoryListingSuccess(model));
        } else {
          emit(CategoryListingError(''));
        }
      } catch (error, stack) {
        print(stack.toString());
        emit(CategoryListingError(error.toString()));
      }
    }
  }
}